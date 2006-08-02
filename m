Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWHBMyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWHBMyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 08:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWHBMyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 08:54:40 -0400
Received: from mx1.suse.de ([195.135.220.2]:58813 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751169AbWHBMyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 08:54:39 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] x86: rename is_at_popf(), add iret to tests and fix insn length
Date: Wed, 2 Aug 2006 14:54:33 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <200608020840_MC3-1-C6D8-A1A6@compuserve.com>
In-Reply-To: <200608020840_MC3-1-C6D8-A1A6@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608021454.33685.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 August 2006 14:37, Chuck Ebbert wrote:
> is_at_popf() needs to test for the iret instruction as well as
> popf.  So add that test and rename it to is_setting_trap_flag().

Do you have a single real example where anybody is actually using IRET
in user space? 

-Andi

