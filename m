Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSGYSYg>; Thu, 25 Jul 2002 14:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSGYSYg>; Thu, 25 Jul 2002 14:24:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33007 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S310190AbSGYSYf>;
	Thu, 25 Jul 2002 14:24:35 -0400
Date: Thu, 25 Jul 2002 14:27:48 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rik van Riel <riel@conectiva.com.br>
cc: Anton Altaparmakov <aia21@cantab.net>,
       Linus Torvalds <torvalds@transmeta.com>, Matt_Domsch@Dell.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: RE: 2.5.28 and partitions
In-Reply-To: <Pine.LNX.4.44L.0207251457180.8815-100000@duckman.distro.conectiva>
Message-ID: <Pine.GSO.4.21.0207251420570.17621-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Jul 2002, Rik van Riel wrote:

> On Thu, 25 Jul 2002, Alexander Viro wrote:
> > On Thu, 25 Jul 2002, Anton Altaparmakov wrote:
> > > At 12:44 25/07/02, Alexander Viro wrote:
> 
> > > It's one database, and it's huge.
> >
> > ... and backups of your database are done on...?
> 
> LVM snapshot + rsync to an identical machine elsewhere ?

	Works fine until you find a nasty bug in (identical) firmware.

<cue story about RAID5 built out of a bunch of Seagates; a year later
6 disks out of 16 went to hell during a weekend - ones that had
serial numbers within a $SMALLNUM from each other>

And that's aside of the "wisdom" of using LVM...

