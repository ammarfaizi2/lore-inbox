Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262691AbRE0BcP>; Sat, 26 May 2001 21:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262692AbRE0BcG>; Sat, 26 May 2001 21:32:06 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:41488 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S262691AbRE0Bbw>; Sat, 26 May 2001 21:31:52 -0400
Date: Sun, 27 May 2001 03:30:09 +0200
From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE Performance lack !
Message-ID: <20010527033009.B9762@lisa.links2linux.home>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <01052622193100.01317@linux.zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01052622193100.01317@linux.zuhause.de>; from stepken@little-idiot.de on Sat, May 26, 2001 at 10:19:31PM +0200
X-Operating-System: Linux 2.2.18-lisa01 i586
X-Editor: VIM 5.7.8
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Guido Stepken schrieb am 26.05.01 um 22:19 Uhr:
> Hi !
> 
> RedHat 7.1 - IDE IBM 41.1 GIG
> Update to 2.4.5 -> noticed, that hdparm -t /dev/hda went down from 10 
> MByte/sec to 1.9 MByte/sec
> Any special Options, beside ide-scsi driver activated ..
> 
> Anybody noticed the same problem ? Any clues ?
> 
> tnx in advance ...

Hi Guido,

This is a 20.1 GB Seagate Barracuda (with hdparm -d1)


homer:~ # hdparm -t /dev/hda
 
/dev/hda:
 Timing buffered disk reads:  64 MB in  2.74 seconds = 23.36 MB/sec
homer:~ #


Did you turn on dma-mode?

-Marc

-- 
+-O . . . o . . . O . . . o . . . O . . .  ___  . . . O . . . o .-+
| Ein neuer Service von Links2Linux.de:   /  o\   RPMs for SuSE   |
| --> PackMan! <-- naeheres unter        |   __|   and  others    |
| http://packman.links2linux.de/ . . . O  \__\  . . . O . . . O . |
