Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUA3R1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUA3R1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:27:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:35525 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262128AbUA3R1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:27:01 -0500
Date: Fri, 30 Jan 2004 09:27:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: s864@ii.uib.no (Ronny V. Vindenes)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc2-mm2
Message-Id: <20040130092739.0700caff.akpm@osdl.org>
In-Reply-To: <m3d691n14e.fsf@terminal124.gozu.lan>
References: <1jDrO-4xh-13@gated-at.bofh.it>
	<m3d691n14e.fsf@terminal124.gozu.lan>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s864@ii.uib.no (Ronny V. Vindenes) wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2.6.2-rc2-mm2/
> > 
> > 
> > - I added a few late-arriving patches.  Usually this breaks things.
> > 
> 
> I got a reject in include/linux/sched.h,

yes, sorry about that.  I uploaded a new 2.6.2-rc2-mm2-1.gz

> it still compiles but doesn't boot,
> the harddisks (2 sata + a pata) makes some wierd noises but no signs
> of booting. -mm1 works fine (with the futex debug patch reverted).

I don't know what could be the cause of that.  You could check those config
optons and do a `make clean'.
