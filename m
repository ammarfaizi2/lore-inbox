Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262417AbTCMQTM>; Thu, 13 Mar 2003 11:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262427AbTCMQTM>; Thu, 13 Mar 2003 11:19:12 -0500
Received: from cibs9.sns.it ([192.167.206.29]:54285 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S262417AbTCMQTL>;
	Thu, 13 Mar 2003 11:19:11 -0500
Date: Thu, 13 Mar 2003 17:29:30 +0100 (CET)
From: venom@sns.it
To: Tomas Szepe <szepe@pinerecords.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, James Stevenson <james@stev.org>,
       pd dd <parviz_kernel@yahoo.com>,
       "M. Soltysiak" <msoltysiak@hotmail.com>,
       ML-linux-kernel <linux-kernel@vger.kernel.org>,
       William Stearns <wstearns@pobox.com>
Subject: re: Linux BUG: Memory Leak
In-Reply-To: <20030313150544.GC5488@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.43.0303131724430.19756-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

slackware 8.1 could have problems, if you upgrade to XFree86 4.3 manually with
the precompiled binaries you can download from xfree86.org if you still use the
DRM modules coming with the kernel 2.4.18 vanilla. AT less you will have to
download and recompile correct DRM modules.

Slackware 9.0 (now rc2) has Xfree86 4.3 compiled with glibc 2.3.1, and kernel
2.4.20 with
some patches. This slackware ships also the correct DRM modules to work
correctly on XFree86 4.3.

That just to clarify esplicitally this question


Bests

Luigi


On Thu, 13 Mar 2003, Tomas Szepe wrote:

> Date: Thu, 13 Mar 2003 16:05:44 +0100
> From: Tomas Szepe <szepe@pinerecords.com>
> To: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: James Stevenson <james@stev.org>, pd dd <parviz_kernel@yahoo.com>,
>      M. Soltysiak <msoltysiak@hotmail.com>,
>      ML-linux-kernel <linux-kernel@vger.kernel.org>,
>      William Stearns <wstearns@pobox.com>
> Subject: re: Linux BUG: Memory Leak
>
> > [alan@lxorguk.ukuu.org.uk]
> >
> > There were problems with the XFree 4.3 DRM if you mixed it with
> > certain other ingredients like rmap. I don't know what Slackware
> > ships but that may be the problem.
>
> Slackware 8.1 shipped with XFree 4.2.0 and linux-2.4.18 vanilla.
>
> Slackware 9.0 will probably ship with XFree 4.3.0 and linux-2.4.20
> with Andrew Morton's ext3 patches.
>
> As far as I can tell, DRM has worked nicely with both 8.1 and 9.0-rc[12].
>
> --
> Tomas Szepe <szepe@pinerecords.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

