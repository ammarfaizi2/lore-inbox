Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSEZG5H>; Sun, 26 May 2002 02:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSEZG5G>; Sun, 26 May 2002 02:57:06 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:61406 "EHLO
	postfix2-1.free.fr") by vger.kernel.org with ESMTP
	id <S315758AbSEZG5F>; Sun, 26 May 2002 02:57:05 -0400
Message-Id: <200205260654.g4Q6sld07709@colombe.home.perso>
Date: Sun, 26 May 2002 08:54:44 +0200 (CEST)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: 2.4.19-pre8-ac5 swsusp panic
To: matthias.andree@stud.uni-dortmund.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020525232051.GC19125@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26 Mai, Matthias Andree a écrit :
> On Sat, 25 May 2002, fchabaud@free.fr wrote:
> 
>> Le 24 Mai, Matthias Andree a écrit :
>> > I tried SysRq-D and finally got a kernel "panic: Request while ide driver
>> > is blocked?"
>> > 
>> > Before that, I saw "waiting for tasks to stop... suspending kreiserfsd",
>> > nfsd exiting, "Freeing memory", "Syncing disks beofre copy", then some
>> > "Probem while suspending", then some "Resume" and finally the panic.
>> > 
>> > It may be worth noting that one swap partition is on a SCSI drive, and
>> > that my IDE drives were in standby (not idle) mode, i. e. their spindle
>> > motors were stopped.
>> 
>> AFAIK swap partition under SCSI is not supported for the moment.
> 
> Gee. Swsusp should know when it must panic later and not start in the
> first place. If that's true: swsusp people, consider this a feature
> request ;-)
> 

I'll do it. Besides I don't imagine it's too difficult to support SCSI,
but I had no time before for doing this.

--
Florent Chabaud
http://www.ssi.gouv.fr | http://fchabaud.free.fr

