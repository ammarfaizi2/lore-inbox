Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267084AbSLKJ1c>; Wed, 11 Dec 2002 04:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267085AbSLKJ1c>; Wed, 11 Dec 2002 04:27:32 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:27544 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267084AbSLKJ1b>; Wed, 11 Dec 2002 04:27:31 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: CD Writing in 2.5.51
References: <1039598049.480.7.camel@nirvana>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Wed, 11 Dec 2002 10:34:43 +0100
In-Reply-To: <1039598049.480.7.camel@nirvana> (mdew's message of "11 Dec
 2002 22:14:07 +1300")
Message-ID: <87fzt43nm4.fsf@web.de>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* mdew  writes:
>So many howto's for writing in 2.4.x, simply put, what do i need
>(kernel-wise) to get IDE CD writing going? 

>the lwn.net announcements dont really explain what needs to been done,
>what modules need to be loaded (and what I dont need anymore) etc.

You don't need any additional modules. Just don't activate ide-scsi by
either not appending ide-scsi/scsi=hdX or not compiling ide-scsi
support in the kernel. 

You also need a recent version of cdrtools. Just take the latest
cdrtools-2.0pre version. cdrdao won't work yet without moving the new
libscg from cdrtools to cdrdao, but it's not too hard to do and if you
complain on the cdrdao list they will perhaps update it themselves
sooner ;-)
After that is done you can burn your disks with dev=/dev/hdX.

regards
Markus

