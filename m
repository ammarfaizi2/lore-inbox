Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbTAGWW2>; Tue, 7 Jan 2003 17:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267535AbTAGWV4>; Tue, 7 Jan 2003 17:21:56 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:42511 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267534AbTAGWVy>; Tue, 7 Jan 2003 17:21:54 -0500
Message-ID: <3E1B3A49.42F6370E@linux-m68k.org>
Date: Tue, 07 Jan 2003 21:36:25 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@pyxtechnologies.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
References: <Pine.LNX.4.10.10301061625150.421-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andre Hedrick wrote:

> Please continue to think of TCP checksums as valid for a data transport,
> you data will be gone soon enough.
> 
> Initiator == Controller
> Target == Disk
> iSCSI == cable or ribbon
> 
> Please turn off the CRC on your disk drive and see if you still have data.

This maybe works as PR, but otherwise it's crap.
With a network protocol you have multiple possibilities to increase the
reliability. The lower you do it in the network layer the easier is it
to put it into hardware and to optimize it and the more generically it's
usable. Doing it in the protocol is only the last resort. The iSCSI
protocol is a nice protocol - if you ignore all the crap the hardware
vendors put in (that stuff only makes sense if you want to produce ultra
cheap hardware).

bye, Roman


