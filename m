Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318607AbSHPRLl>; Fri, 16 Aug 2002 13:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318608AbSHPRLl>; Fri, 16 Aug 2002 13:11:41 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:22469 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318607AbSHPRLZ>; Fri, 16 Aug 2002 13:11:25 -0400
Message-ID: <3D5D3310.5D4A4545@wanadoo.fr>
Date: Fri, 16 Aug 2002 19:14:56 +0200
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre2 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: Andrew Rodland <arodland@noln.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac3 stops responding
References: <Pine.LNX.4.44L.0208161036170.1430-100000@imladris.surriel.com>
		<3D5D287C.F4AE3797@wanadoo.fr> <20020816124415.467e662e.arodland@noln.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Rodland wrote:
> 
> On Fri, 16 Aug 2002 18:29:48 +0200
> Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr> wrote:
> 
> > Rik van Riel wrote:
> > >
> > > On Fri, 16 Aug 2002, Jean-Luc Coulon wrote:
> > >
> > > > 2nd while running:
> > > > ------------------
> > > > If I have high disk activity, the system stops responding for a
> > > > while, it does not accepts any key action nor mouse movement. It
> > > > starts running normally after few seconds.
> > /dev/hda2:
> > multcount    =  1 (on)
> > IO_support   =  1 (32-bit)
> > unmaskirq    =  0 (off)
> > using_dma    =  0 (off)
> > keepsettings =  0 (off)
> > readonly     =  0 (off)
> > readahead    =  8 (on)
> > geometry     = 3649/255/63, sectors = 29302560, start = 9767520
> > HDIO_GET_IDENTITY failed: Invalid argument
> >
> > [root@debian-f5ibh] ~ # hdparm -d1 /dev/hda2
> >
> > /dev/hda2:
> > setting using_dma to 1 (on)
> > HDIO_SET_DMA failed: Invalid argument
> > using_dma    =  0 (off)
> >
> how about umaskirq (hdparm -u1) ? that should help quite a bit, if it
> works.

I can set it up, but I cannot set up the DMA

> 
> oh, and by the way, does it matter that you're doing hdparm on a
> partition rather than the wholedisk?

There is no difference

----
regards
	jean-Luc
