Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267259AbSK3PSu>; Sat, 30 Nov 2002 10:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbSK3PSu>; Sat, 30 Nov 2002 10:18:50 -0500
Received: from odpn1.odpn.net ([212.40.96.53]:22021 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id <S267259AbSK3PSt>;
	Sat, 30 Nov 2002 10:18:49 -0500
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: Re: hda: task_no_data_intr
References: <34e8.3de88c28.44a4f@gzp1.gzp.hu> <200211301345.gAUDjoiZ000163@darkstar.example.net>
Organization: Who, me?
User-Agent: tin/1.5.16-20021120 ("Spiders") (UNIX) (Linux/2.4.20-gzp2 (i686))
Message-ID: <9f8.3de8d895.50aae@gzp1.gzp.hu>
Date: Sat, 30 Nov 2002 15:26:13 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Bradford <john@grabjohn.com>:

|> Tried with 3 different hard disks, and got the same message
|> every time.
| 
| Are they all of a similar age/capacity?

QUANTUM FIREBALL ST4.3A from 1998
QUANTUM Pioneer SG 1GB from ~1996
WD Caviar 1GB from ~1998

|> Seems like I'm also unable to make ext3 fs on the disks.
| 
| What is the exact problem?

mke2fs -j says 'no such file: mke2fs' at building the
filesystem on the 1GB disks, and I'm able to make ext3 on
the 4.3 Quantum, but I'm unable to mount it as ext3:

EXT2-fs warning (device ide0(3,1)): ext2_read_super: mounting ext3 filesystem as ext2

