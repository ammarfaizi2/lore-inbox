Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSEYIPH>; Sat, 25 May 2002 04:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314101AbSEYIPG>; Sat, 25 May 2002 04:15:06 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:31717 "EHLO
	postfix1-2.free.fr") by vger.kernel.org with ESMTP
	id <S314096AbSEYIPF>; Sat, 25 May 2002 04:15:05 -0400
Message-Id: <200205250800.g4P80F124063@colombe.home.perso>
Date: Sat, 25 May 2002 10:00:12 +0200 (CEST)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: 2.4.19-pre8-ac5 swsusp panic
To: matthias.andree@stud.uni-dortmund.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020524011322.GA6612@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24 Mai, Matthias Andree a écrit :
> I tried SysRq-D and finally got a kernel "panic: Request while ide driver
> is blocked?"
> 
> Before that, I saw "waiting for tasks to stop... suspending kreiserfsd",
> nfsd exiting, "Freeing memory", "Syncing disks beofre copy", then some
> "Probem while suspending", then some "Resume" and finally the panic.
> 
> It may be worth noting that one swap partition is on a SCSI drive, and
> that my IDE drives were in standby (not idle) mode, i. e. their spindle
> motors were stopped.
> 

AFAIK swap partition under SCSI is not supported for the moment.

--
Florent Chabaud

