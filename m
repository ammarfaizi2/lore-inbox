Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266985AbRGHXxB>; Sun, 8 Jul 2001 19:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbRGHXww>; Sun, 8 Jul 2001 19:52:52 -0400
Received: from outmail1.pacificnet.net ([207.171.0.246]:32116 "EHLO
	outmail1.pacificnet.net") by vger.kernel.org with ESMTP
	id <S266985AbRGHXwl>; Sun, 8 Jul 2001 19:52:41 -0400
Message-ID: <004c01c10809$0dc310a0$5d910404@molybdenum>
From: "Jahn Veach - Veachian64" <V64@Galaxy42.com>
To: "Keith Owens" <kaos@ocs.com.au>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <24743.994632696@ocs3.ocs-net>
Subject: Re: Unresolved symbols in 2.4.6 
Date: Sun, 8 Jul 2001 18:52:28 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2001 05:51:42 -0600,
"Keith Owens" <kaos@ocs.com.au> wrote:
> You do nm on vmlinux, not vmlinuz.  vmlinux is in the top level
> directory of the kernel source tree after the build.

nm vmlinux | grep printk

c024f44e ? __kstrtab_printk
c0254870 ? __ksymtab_printk
c0113494 T printk
c017c6ec t printk_pnp_dev_id


