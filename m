Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTDCTpG 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263538AbTDCTpG 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:45:06 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:42745 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S263535AbTDCTpC 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 14:45:02 -0500
Date: Thu, 3 Apr 2003 11:53:52 -0800
From: Chris Wright <chris@wirex.com>
To: James Cownie <jcownie@etnus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ptrace patch fails stress testing
Message-ID: <20030403115352.A13796@figure1.int.wirex.com>
Mail-Followup-To: James Cownie <jcownie@etnus.com>,
	linux-kernel@vger.kernel.org
References: <1916YC-0Qp-00@etnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1916YC-0Qp-00@etnus.com>; from jcownie@etnus.com on Thu, Apr 03, 2003 at 04:22:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Cownie (jcownie@etnus.com) wrote:
> 
> We're seeing this 100% reliably with out TotalView debugger, and as
> Alan suggests it happens when trying to make a ptrace call on a zombie
> process.

Yup, I can reliably reproduce this as well.  I'm also using the same patch
in is_dumpable().

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
