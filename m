Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbTARJCN>; Sat, 18 Jan 2003 04:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbTARJCM>; Sat, 18 Jan 2003 04:02:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:51337 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263544AbTARJCL>;
	Sat, 18 Jan 2003 04:02:11 -0500
Message-Id: <5.1.1.6.2.20030118100548.00c4e5b8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Sat, 18 Jan 2003 10:07:55 +0100
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Mikael Pettersson <mikpe@csd.uu.se>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
Cc: rusty@rustcorp.com.au, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0301171808010.15056-100000@chaos.physics.uio
 wa.edu>
References: <15911.64825.624251.707026@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:11 PM 1/17/2003 -0600, Kai Germaschewski wrote:
>On Fri, 17 Jan 2003, Mikael Pettersson wrote:
>
> > This oops occurs for every module, not just af_packet.ko, at
> > resolve_symbol()'s first call to __find_symbol().
>
>Okay, the details I received so far seem to indicate that the appended
>patch will fix it, though I didn't get actual confirmation it does.
>
>If you experience crashes when loading modules (and have RH 8 binutils),
>please give it a shot.

Works fine with 2.13.90.0.10 (not RH) and 2.13.2, both of which failed 
previously.

         thanks,

         -Mike


