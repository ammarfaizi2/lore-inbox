Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269903AbUJMXBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269903AbUJMXBb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269905AbUJMXBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:01:31 -0400
Received: from ozlabs.org ([203.10.76.45]:54454 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269903AbUJMXBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:01:16 -0400
Subject: Re: [PATCH] Weak symbols in modules and versioned symbols
From: Rusty Russell <rusty@rustcorp.com.au>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041013145844.GA16067@vana.vc.cvut.cz>
References: <20041013145844.GA16067@vana.vc.cvut.cz>
Content-Type: text/plain
Message-Id: <1097708463.14303.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 14 Oct 2004 09:01:25 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 00:58, Petr Vandrovec wrote:
> Hello,
>   is there some reason why to not apply patch below?  Without patch below
> I'm getting
> 
> vmmon: no version for "sys_ioctl" found: kernel tainted.

Sure, patch seems fine to me.  I guess you're the first one to use weak
symbols in a module.  In fact, I think PPC64 might barf on them anyway.

Please ensure you've read Documentation/SubmittingPatches line 262
onwards "11) Sign your work" and resend to me off-line.

Thanks!
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

