Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284191AbRLASPS>; Sat, 1 Dec 2001 13:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284189AbRLASPI>; Sat, 1 Dec 2001 13:15:08 -0500
Received: from cs6669235-16.austin.rr.com ([66.69.235.16]:33664 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S284188AbRLASO6>; Sat, 1 Dec 2001 13:14:58 -0500
Date: Sat, 1 Dec 2001 12:14:47 -0600 (CST)
From: Erik Elmore <lk@bigsexymo.com>
X-X-Sender: <lk@localhost.localdomain>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: EXT3 - freeze ups during disk writes
In-Reply-To: <20011130235414.E489@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.33.0112011209190.3893-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ahhhh... woops... every official kernel since ext3 made it into the 
official tree, 2.4.14 if memory serves.  I'm using gcc 2.95.3.  And to 
clarify the bug, say on a large disk write, the pause isn't constant, 
it just pauses for a second every few seconds during the write.  For 
smaller writes, it will pause only once, I assume while performing the 
actual write to disk.

Erik


On Fri, 30 Nov 2001, Mike Fedyk wrote:

> On Sat, Dec 01, 2001 at 12:47:19AM -0600, Erik Elmore wrote:
> > Ever since I started using ext3fs, whenever there is a disk write, the 
> > kernel sucks up all of the CPU thereby preempting everything and causing 
> > the PC to freeze momentarily.  Could this possibly be caused by the 
> > journaling code in ext3?
> > 
> 
> You really need to give kernel version, gcc version and what things were
> happening at the time.
> 
> I can think of five different things that this general description has
> brought up.
> 
> mf
> 

