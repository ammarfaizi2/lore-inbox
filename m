Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSIHRaS>; Sun, 8 Sep 2002 13:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSIHRaS>; Sun, 8 Sep 2002 13:30:18 -0400
Received: from 62-190-216-149.pdu.pipex.net ([62.190.216.149]:50182 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S317191AbSIHRaR>; Sun, 8 Sep 2002 13:30:17 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209081742.g88HgUeO003421@darkstar.example.net>
Subject: Re: ide drive dying?
To: Dieter.Nuetzel@hamburg.de (Dieter =?iso-8859-15?q?N=FCtzel?=)
Date: Sun, 8 Sep 2002 18:42:29 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209080159.47115.Dieter.Nuetzel@hamburg.de> from "Dieter =?iso-8859-15?q?N=FCtzel?=" at Sep 08, 2002 02:02:35 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andre, can you fix start/stop counts, please?
> 
> unWave1 /home/nuetzel# /usr/local/sbin/smartctl -a /dev/sda
> Device: IBM      DDYS-T18350N     Version: S96H
> Device supports S.M.A.R.T. and is Enabled
> Temperature Warning Disabled or Not Supported
> S.M.A.R.T. Sense: Okay!
> Current Drive Temperature:     31 C
> Drive Trip Temperature:        85 C
> Current start stop count:      131072 times
> Recommended start stop count:  2555920 times
> 
> SunWave1 /home/nuetzel# /usr/local/sbin/smartctl -a /dev/sdb
> Device: IBM      DDRS-34560D      Version: DC1B
> Device supports S.M.A.R.T. and is Enabled
> Temperature Warning Disabled or Not Supported
> S.M.A.R.T. Sense: Okay!
> 
> SunWave1 /home/nuetzel# /usr/local/sbin/smartctl -a /dev/sdc
> Device: IBM      DDRS-34560W      Version: S71D
> Device supports S.M.A.R.T. and is Enabled
> Temperature Warning Disabled or Not Supported
> S.M.A.R.T. Sense: Okay!
> 
> Smartsuite-2.1 (at least) missing some feather for SCSI.

Are you sure that it is not just the drive mis-reporting the start/stop counts?  S.M.A.R.T. implementions are often flakey.

> BTW
> I had a double disk crash (same symptoms as in this thread) in a school's 
> RAID5 with four Fujitsu MPG3204AT-EF (the ones with gel-lager, silent and 
> reliable we hoped) last week...
> The shop for which I work from time to time got 71 disks of this type back 
> (sold over the last 1.5 years). We switched to them after the "IBM" disaster. 
> Maybe a "misdecision" ;-)
> What shall we sell safely, now...?
> MAXTOR?

I have *never* lost data to a Maxtor disk.  I have had IBM, Fujitsu, Western Digital, and DEC drives all fail on me before.

It's dissapointing that Maxtor are reducing their warranty from 3 years to 1 year, but on the other hand, I've never needed it at all.

John.
