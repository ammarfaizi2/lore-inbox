Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWBBQfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWBBQfd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWBBQfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:35:33 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:51146 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932147AbWBBQfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:35:32 -0500
Date: Thu, 2 Feb 2006 17:35:24 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Rene Herman <rene.herman@keyaccess.nl>
cc: Albert Cahalan <acahalan@gmail.com>,
       "David S. Miller" <davem@davemloft.net>, gmack@innerfire.net,
       diablod3@gmail.com, schilling@fokus.fraunhofer.de, bzolnier@gmail.com,
       mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux try #2
In-Reply-To: <43E09CA6.4050605@keyaccess.nl>
Message-ID: <Pine.LNX.4.61.0602021731270.13212@yvahk01.tjqt.qr>
References: <200601302043.56615.diablod3@gmail.com> 
 <20060130.174705.15703464.davem@davemloft.net>  <Pine.LNX.4.64.0601310609210.2979@innerfire.net>
  <20060131.031817.85883571.davem@davemloft.net>
 <787b0d920601312049n313364a1q8a41e10c3cda98e0@mail.gmail.com>
 <43E09CA6.4050605@keyaccess.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> There are all sorts of funky formats. I've only ever heard of mixed
>> audio+data CDs for circa-1995 games and Sony spyware, but maybe there
>> are decent people who actually create these things.
>
> These are in fact very common. Lots of audio CDs, with a data bit with a few
> quicktime/mpeg videos.

For the record, so-called Mixed Mode discs consisting of

  Session 1 >>
    Track 1 (Data)
    Track 2 (Audio)
    Track 3 (Audio)
    ...

exist(ed) quite a lot, when games were smaller than the audio. (Now that we 
have things like Doom3 and Ogg, this has sadfully turned around.) To name 
two of such mixedmode CDs from "popular games":
  Microsoft Fury3 and MechWarrior2 (Matrox Mystique W95 Edition)

The other type of "mixed-mode" CDs are the so-called "CD Extra", which is:

  Session 1 >>
    Track 1 (Audio)
    Track 2 (Audio)
    ...
  Session 2 >>
    Track N (Data)

from what I remember, "Music Instructor - Get freaky" was such a CD where 
the iso9660 track had an .mpg video clip. This was done so legacy audio 
players don't play all the fizzle (cat /dev/cdrom >/dev/dsp) through their 
speakers and damage them.
(I tried in the oldest HiFi stuff I could dig up, e.g. SONY UX-1 - stayed 
correctly silent on Data tracks ;-)



Jan Engelhardt
-- 
