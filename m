Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269127AbUJKQCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269127AbUJKQCE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 12:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbUJKP6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:58:13 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:45445 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S269065AbUJKP5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:57:52 -0400
Date: Mon, 11 Oct 2004 18:58:01 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc4-mm1
In-Reply-To: <20041011154934.GD26350@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0410111857260.2869@musoma.fsmlabs.com>
References: <20041011032502.299dc88d.akpm@osdl.org>
 <Pine.LNX.4.61.0410111844450.2873@musoma.fsmlabs.com> <20041011154934.GD26350@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004, Andi Kleen wrote:

> On Mon, Oct 11, 2004 at 06:47:45PM +0300, Zwane Mwaikambo wrote:
> > How about the following?
> > 
> > remove-lock_section-from-x86_64-spin_lock-asm.patch
> >   remove LOCK_SECTION from x86_64 spin_lock asm
> > 
> > allow-x86_64-to-reenable-interrupts-on-contention.patch
> >   Allow x86_64 to reenable interrupts on contention
> > 
> > The former is a fix.
> 
> What does it fix? 

Well we don't have lock section anymore since the spinlock text is all in 
the out of line functions. So this was really something i missed in my 
sweep.

