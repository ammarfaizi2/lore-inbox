Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131134AbRAPXcj>; Tue, 16 Jan 2001 18:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129749AbRAPXca>; Tue, 16 Jan 2001 18:32:30 -0500
Received: from jalon.able.es ([212.97.163.2]:9391 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129610AbRAPXcV>;
	Tue, 16 Jan 2001 18:32:21 -0500
Date: Wed, 17 Jan 2001 00:32:05 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Michael Meissner <meissner@spectacle-pond.org>
Cc: "'linux-scsi @ vger . kernel . org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel @ vger . kernel . org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010117003205.A711@werewolf.able.es>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95191@ATL_MS1> <Pine.LNX.4.21.0101161154580.17397-100000@sol.compendium-tech.com> <20010116153757.A1609@munchkin.spectacle-pond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010116153757.A1609@munchkin.spectacle-pond.org>; from meissner@spectacle-pond.org on Tue, Jan 16, 2001 at 21:37:57 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.16 Michael Meissner wrote:
> On Tue, Jan 16, 2001 at 12:01:12PM -0800, Dr. Kelsey Hudson wrote:
> > On Tue, 16 Jan 2001, Venkatesh Ramamurthy wrote:
..
> > besides, how many 'end-users' do you know of that will have multiple scsi
> > adapters in one system? how many end-users -period- will have even a
> > *single* scsi adapter in their systems? do we need to bloat the kernel
> > with automatic things like this? no... i think it is handled fine the way
> > it is. if the user wants to add more than one scsi adapter into his
> > system, let him read some documentation on how to do so. (is this even a
> > documented feature? if not, i think it should be added to the docs...)
> 
> I'm an end-user, and I have 3 scsi-adapters of two different brands in my
> system.  Many of the people using Linux in high end things like servers,
> etc. will have multiple scsi controlers.  People are using Linux in lots of
> things from small embedded devices to large systems, and Linux needs to
> address
> needs in every area.
> 

If that is your idea of the average user... You're a system administrator, 
you can have tons of scsi cards in your system if you want.

You want to make things SOOO easy for a 'dummy' user, and that user will never 
use them. The average user you are targetting says: 'daddy, buy me a PC to
run Quake and do my school jobs' or 'please, dear vendor, I want a PC to
do my housekeeping'. I have seen so many cases (A buys PC, A tries to run
brand new racing game that does not work, A goes shop and says: don't know
what's wrong with this PC, look at it and call me when MyCarRacingGame 
works...).

Average users you are targetting with that automagical
card detection even do not know there are SCSI and IDE disks. They just
want a 30Gb ide disk to install linux and play. If they involve with SCSI
and ID numbers and multiple cards and so on they can read some docs and
rebuild a kernel.


-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.0-ac9 #2 SMP Sun Jan 14 01:46:07 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
