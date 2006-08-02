Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWHBNk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWHBNk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 09:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWHBNk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 09:40:28 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:37559 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750835AbWHBNk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 09:40:27 -0400
Date: Wed, 2 Aug 2006 09:35:40 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] x86: rename is_at_popf(), add iret to tests and
  fix insn length
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Albert Cahalan <acahalan@gmail.com>
Message-ID: <200608020937_MC3-1-C6D7-3958@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200608021454.33685.ak@suse.de>

On Wed, 2 Aug 2006 14:54:33 +0200. Andi Kleen wrote:

> > is_at_popf() needs to test for the iret instruction as well as
> > popf.  So add that test and rename it to is_setting_trap_flag().
> 
> Do you have a single real example where anybody is actually using IRET
> in user space? 

No, but Albert Cahalan complained so I figured it should be fixed.

-- 
Chuck

