Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVCVAVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVCVAVU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVCVATQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:19:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:45293 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262211AbVCVARM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:17:12 -0500
Date: Mon, 21 Mar 2005 16:13:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: airlied@gmail.com, linux-kernel@vger.kernel.org, keenanpepper@gmail.com
Subject: Re: i830 DRM problems
Message-Id: <20050321161356.5e1002dd.akpm@osdl.org>
In-Reply-To: <423F5A0A.7060307@ens-lyon.org>
References: <422C5A25.3000701@ens-lyon.org>
	<21d7e99705031115075e4378ed@mail.gmail.com>
	<20050321151453.695c73e2.akpm@osdl.org>
	<423F5A0A.7060307@ens-lyon.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>
> Andrew Morton a écrit :
> > Dave Airlie <airlied@gmail.com> wrote:
> > 
> >>>I am experiencing problems with DRM on my Dell Optiplex GX260.
> >>>I am running a Debian Sarge with Vanilla Linux 2.6.11 and XFree 4.3.0.
> >>>This one appeared while playing crack-attack and lead to a crash
> >>>of the X server.
> >>>
> >>
> >>a) does it work with 2.6.10?
> >>b) does it work if you turn off intelfb?
> >>
> > 
> > afacit we're still waiting for an answer from Brice on this one?
> 
> Sorry about that, we start to talk about it in private with Dave.
> But, I did not really it since Keenan Pepper told me it was due
> to a bug in the XFree 4.3 driver.
> I am now using Xorg and didn't see any DRM problem since.
> However, I can't confirm that my bug was surely due to the XFree driver 
> and not to the kernel driver since Xorg uses i915 instead of i830.
> Keenan, do you have details ?

OK, that sounds promising.  Would you view this as a regression?  Was XFree
4.3 working OK on earlier 2.6 kernels?


> I was also talking about a problem in intelfb on this box (i845G).
> Basically, it works great during startup. But from what I remember, it
> always crashes when switching from X to a text console.
> I'll try to debug this one soon.

Great.  Please cc linux-fbdev-devel@lists.sourceforge.net and myself when
you have more.

