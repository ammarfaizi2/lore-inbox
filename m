Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264536AbRFJP6K>; Sun, 10 Jun 2001 11:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264537AbRFJP57>; Sun, 10 Jun 2001 11:57:59 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:44806 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S264536AbRFJP5n>;
	Sun, 10 Jun 2001 11:57:43 -0400
Date: Sun, 10 Jun 2001 17:57:30 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.5-ac12] New Sony Vaio Motion Eye camera driver
Message-ID: <20010610175730.B15945@ontario.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20010610152526.B13172@ontario.alcove-fr> <E1596NC-0006g5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <E1596NC-0006g5-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jun 10, 2001 at 03:39:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2001 at 03:39:26PM +0100, Alan Cox wrote:

> > The driver does not yet support overlay (no docs... :-( ), but it does =
> > support
> 
> Are you sure the hardware supports overlay ?

Yes. But, even if I know how to program the mchip to output to
the video bus, there is something missing to enable overlay
(either in the mchip or in the ati video driver).

> > grabbing, jpeg snapshots and mjpeg compressed videos (through a private=
> >  API,
> > documented in <file:Documentation/video4linux/meye.txt>).
> 
> We have an API for mjpeg in the buz, I wonder if its possible to make that
> more generic.

I started with that one and abandoned it later, since it is really
targeted to _tv_ capture cards only (the size of capture can be only 
the PAL/NTSC size, and many other little things, like framerate 
fixed to PAL/NTSC mode too etc.)

Maybe video4linux version 2 will be a more useful API for all
cameras / webcams / video capture cards. (almost a carbon copy
of what I say in Documentation/video4linux/meye.txt :-) ).

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
