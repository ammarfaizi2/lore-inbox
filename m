Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289160AbSAGJvg>; Mon, 7 Jan 2002 04:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289158AbSAGJv0>; Mon, 7 Jan 2002 04:51:26 -0500
Received: from mx03.uni-tuebingen.de ([134.2.3.13]:15369 "EHLO
	mx03.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S289087AbSAGJvU>; Mon, 7 Jan 2002 04:51:20 -0500
Date: Mon, 7 Jan 2002 10:51:14 +0100 (CET)
From: Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>
To: Oliver Paukstadt <pstadt@stud.fh-heilbronn.de>
cc: Andrew Morton <akpm@zip.com.au>, Matti Aarnio <matti.aarnio@zmailer.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        <linux-raid@vger.kernel.org>
Subject: Re: 2.4.17 RAID-1 EXT3  reliable to hang....
In-Reply-To: <Pine.LNX.4.33.0201070933590.4076-100000@lola.stud.fh-heilbronn.de>
Message-ID: <Pine.LNX.4.33.0201071047410.17279-100000@bellatrix.tat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Oliver Paukstadt wrote:

> Heavy traffic on ext3 seems to cause short system freezes.

I see dropped frames while watching TV (bttv chip, xawtv in overlay mode,
XFree 4.1.0)
since I use ext3 (2.4.16&17). Always during disk activity (IDE, umask irq
and dma enabled). From what I know the bttv driver does it seems to loose
interrupts!? This doesnt happen with ext2.

> Seems only to happen on 2 or more processor boxes.

Nope, UP Athlon.

> I'm not deep into kernel nor ext3, but how is the journal flushed if
> full?

By any chance, is some global lock held during any IO intensive part of
ext3?

Richard.

--
Richard Guenther <richard.guenther@uni-tuebingen.de>
WWW: http://www.tat.physik.uni-tuebingen.de/~rguenth/
The GLAME Project: http://www.glame.de/

