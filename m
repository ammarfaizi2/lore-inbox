Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315447AbSEYXVA>; Sat, 25 May 2002 19:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSEYXU7>; Sat, 25 May 2002 19:20:59 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:41994 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S315447AbSEYXU5> convert rfc822-to-8bit; Sat, 25 May 2002 19:20:57 -0400
Date: Sun, 26 May 2002 01:20:51 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre8-ac5 swsusp panic
Message-ID: <20020525232051.GC19125@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020524011322.GA6612@merlin.emma.line.org> <200205250800.g4P80F124063@colombe.home.perso>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 May 2002, fchabaud@free.fr wrote:

> Le 24 Mai, Matthias Andree a écrit :
> > I tried SysRq-D and finally got a kernel "panic: Request while ide driver
> > is blocked?"
> > 
> > Before that, I saw "waiting for tasks to stop... suspending kreiserfsd",
> > nfsd exiting, "Freeing memory", "Syncing disks beofre copy", then some
> > "Probem while suspending", then some "Resume" and finally the panic.
> > 
> > It may be worth noting that one swap partition is on a SCSI drive, and
> > that my IDE drives were in standby (not idle) mode, i. e. their spindle
> > motors were stopped.
> 
> AFAIK swap partition under SCSI is not supported for the moment.

Gee. Swsusp should know when it must panic later and not start in the
first place. If that's true: swsusp people, consider this a feature
request ;-)

-- 
Matthias Andree
