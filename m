Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbWAKQV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbWAKQV1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 11:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWAKQV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 11:21:27 -0500
Received: from mail.gmx.de ([213.165.64.21]:32721 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751362AbWAKQV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 11:21:26 -0500
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm3
Date: Wed, 11 Jan 2006 17:21:23 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <20060111042135.24faf878.akpm@osdl.org>
In-Reply-To: <20060111042135.24faf878.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601111721.23598.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 11. January 2006 13:21, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15
>-mm3/

hi!
it doesn't compile here.

  CC      drivers/media/video/tveeprom.o
  LD      drivers/media/video/built-in.o
drivers/media/video/tuner.o:(.bss+0x0): multiple definition of `debug'
drivers/media/video/msp3400.o:(.bss+0xc): first defined here
make[3]: *** [drivers/media/video/built-in.o] Fehler 1
make[2]: *** [drivers/media/video] Fehler 2
make[1]: *** [drivers/media] Fehler 2
make: *** [drivers] Fehler 2

config file can be downloaded here:
http://stud4.tuwien.ac.at/~e0227135/kernel/config-2.6.15-mm3

greets,
dominik
