Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSGGREz>; Sun, 7 Jul 2002 13:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSGGREy>; Sun, 7 Jul 2002 13:04:54 -0400
Received: from ftp.realnet.co.sz ([196.28.7.3]:35022 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316204AbSGGREy>; Sun, 7 Jul 2002 13:04:54 -0400
Date: Sun, 7 Jul 2002 19:25:27 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ata_special_intr, ide_do_drive_cmd deadlock
In-Reply-To: <Pine.LNX.4.44.0207071916040.1441-100000@linux-box.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0207071922350.1441-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jul 2002, Zwane Mwaikambo wrote:

> > If it was IDE 95, or IDE 95 on atapi device it is known, noted in 95's
> > changelog and fixed in 96...
> 
> On ATA disk, with 2.5.25 stock and the deadlock is still there (visual 
> inspection) in IDE 97

Sorry perhaps let me elaborate, i was doing a dd if=/dev/hdX of=file then 
the drive dropped down to PIO, thats when i reckon i hit do_recalibrate. 
This was on 2.5.25.

Thanks,
	Zwane Mwaikambo

-- 
function.linuxpower.ca



