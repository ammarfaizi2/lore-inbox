Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284251AbRLAVJH>; Sat, 1 Dec 2001 16:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284252AbRLAVI4>; Sat, 1 Dec 2001 16:08:56 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:30985 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284251AbRLAVIo>; Sat, 1 Dec 2001 16:08:44 -0500
Message-ID: <3C0946C7.798208C3@zip.com.au>
Date: Sat, 01 Dec 2001 13:08:23 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Erik Elmore <lk@bigsexymo.com>
CC: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: EXT3 - freeze ups during disk writes
In-Reply-To: <20011130235414.E489@mikef-linux.matchmail.com> <Pine.LNX.4.33.0112011209190.3893-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Elmore wrote:
> 
> ahhhh... woops... every official kernel since ext3 made it into the
> official tree, 2.4.14 if memory serves.  I'm using gcc 2.95.3.  And to
> clarify the bug, say on a large disk write, the pause isn't constant,
> it just pauses for a second every few seconds during the write.  For
> smaller writes, it will pause only once, I assume while performing the
> actual write to disk.
> 

I've seen a couple of reports where ext3 appears to exacerbate
the effects of poor hdparm settings.  What is your raw disk
throughput, from `hdparm -t /dev/hda'?
