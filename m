Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266645AbSL3DzR>; Sun, 29 Dec 2002 22:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266649AbSL3DzR>; Sun, 29 Dec 2002 22:55:17 -0500
Received: from smtp004.mail.tpe.yahoo.com ([202.1.238.135]:11161 "HELO
	smtp004.mail.tpe.yahoo.com") by vger.kernel.org with SMTP
	id <S266645AbSL3DzQ>; Sun, 29 Dec 2002 22:55:16 -0500
Message-ID: <001101c2afb8$6ace8d80$3716a8c0@taipei.via.com.tw>
From: "Joseph" <jospehchan@yahoo.com.tw>
To: "Point Free" <shygin@mail.msiu.ru>
Cc: <linux-kernel@vger.kernel.org>
References: <002801c2acd2$edf6a870$3716a8c0@taipei.via.com.tw><20021226174653.GA8229@kroah.com><003d01c2ad4a$54eb09f0$3716a8c0@taipei.via.com.tw><3E0BC155.5B291F57@eyal.emu.id.au><004e01c2ad85$d9eeb2b0$3716a8c0@taipei.via.com.tw> <20021227143524.659c6595.shygin@mail.msiu.ru>
Subject: Re: [USB 2.0 problem] ASUS CD-RW cannot be mounted.
Date: Mon, 30 Dec 2002 12:02:53 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Check that you actually have /dev/scd0. I think it should be:
> > > # mknod /dev/scd0 b 11 0
> > >
> >  I've checked the node as follows.
> > #ls -l /dec/scd0
> > brw-r----- 1 root  disk 11,  0 Sep 9 13:24 /dev/scd0

> Ouh, could you post your /proc/devices ?

Yeah, that is shown below.
BTW, the ehci-hcd module seems instable. because the CD-RW can work
sometimes.
But it cannot work sometimes. So curiously. ?_?
**
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 vc/%d
  5 ptmx
  6 lp
  7 vcs
 10 misc
 13 input
 14 sound
 21 sg
116 alsa
128 ptm
136 pts
180 usb
226 drm

Block devices:
  2 fd
  3 ide0
  8 sd
 11 sr
 22 ide1
 65 sd
 66 sd
 67 sd
 68 sd
 69 sd
 70 sd
 71 sd
136 sd
137 sd
138 sd
139 sd
140 sd
141 sd
142 sd
143 sd
***

-----------------------------------------------------------------
< ¨C¤Ñ³£ Yahoo!©_¼¯ >  www.yahoo.com.tw
