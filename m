Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265321AbTABQ6r>; Thu, 2 Jan 2003 11:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbTABQ6r>; Thu, 2 Jan 2003 11:58:47 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:7303 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S265321AbTABQ6q>; Thu, 2 Jan 2003 11:58:46 -0500
Message-ID: <20030102150554.85844.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Luca z" <luca22@mail.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Date: Thu, 02 Jan 2003 10:05:54 -0500
Subject: Re: 2-4-18 crash trying to blank a CD
X-Originating-Ip: 151.30.212.48
X-Originating-Server: ws1-8.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Dec 30 16:19:46 koala kernel: scsi : aborting command due to timeout : pid 5233
> > 8, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 13 80 dd 00 00 01 00 
> > Dec 30 16:19:46 koala kernel: SCSI host 0 abort (pid 52338) timed out - resetti
> > ng
> 
> How long after you start the command ? Basically the kernel has
> discovered that the command in question took longer than the timeout
> cdrecord told it to allow. It is then trying to get the system back.

Thank you for your fast response. The problem was the other ATAPI drive
on the same IDE cable. It is died now, those were the synthomps.

> > and after some time it hard freezes, nothing responds, i can't switch numlock
> > off and i can't change to console (i am in XWindow).

Actually it freezed the time needed to blank the CD, about 20 minutes and then
it reborn.
Thank you again.
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Meet Singles
http://corp.mail.com/lavalife

