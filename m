Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267286AbTA0TqS>; Mon, 27 Jan 2003 14:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267287AbTA0TqS>; Mon, 27 Jan 2003 14:46:18 -0500
Received: from [81.2.122.30] ([81.2.122.30]:28421 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267286AbTA0TqR>;
	Mon, 27 Jan 2003 14:46:17 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301271956.h0RJu9Ij001336@darkstar.example.net>
Subject: Re: Hard Disk Failure
To: rtilley@vt.edu (rtilley)
Date: Mon, 27 Jan 2003 19:56:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E3B3FF0@zathras> from "rtilley" at Jan 26, 2003 09:33:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > no.  e2fsprogs might cause data loss, but not
> > physical damage.
> 
> This reminds me of something I read once.
> 
> In his book, Takedown, Tsutomu Shimomura (forgive me if that's
> spelled wrong) wrote a few short paragraphs about how he was able to
> move the head-arm of a magnetic disk drive back and forth with
> software commands. He could tell the head-arm to go to any cylinder
> on the drive, he wondered what would happen if he tried to send it
> to a cylinder that was outside the physical limits of the drive. He
> told the drive (a 200 cylinder drive) to goto cylinder 4000. The
> drive actually tried to go to that cylinder and caused a hardware
> failure in the process.

It's actually possible to make some old mainframe hard disks 'walk'
across the floor, by doing various seeks across the disk :-).

> Is it still possible for software to damage hardware in this fashion
> or is hardware smarter now? Do drives know not to try and access a
> cylinder that is outside their physical limits?

Since modern hard disks are not accessed by their physical
geometries', I would imagine that it would be rare to be able to cause
physical damage to a disk by sending a reference to an out of range
sector.  The disk has to translate the sector you send to it in to
it's real geometry anyway, so there should be no way to translate an
invalid sector in to an invalid physical geometry location, which it
could then not seek to.

John
