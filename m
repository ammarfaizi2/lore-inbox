Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbUDYHcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUDYHcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 03:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUDYHcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 03:32:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:19731 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262217AbUDYHcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 03:32:14 -0400
Date: Sun, 25 Apr 2004 09:29:18 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File system compression, not at the block layer
Message-ID: <20040425072918.GA21148@alpha.home.local>
References: <20040424073622.GN596@alpha.home.local> <200404250305.i3P355eF003826@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404250305.i3P355eF003826@pincoya.inf.utfsm.cl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2004 at 11:05:05PM -0400, Horst von Brand wrote:
 
> >                             Haven't you noticed that drives with many
> > platters are always faster than their cousins with fewer platters ? And
> > I don't speak about access time, but about sequential reads.
> 
> Have you ever wondered how they squeeze 16 or more platters into that slim
> enclosure? If you take them apart, the question evaporates: There are 2 or
> 3 platters in them, no more. The "many platters" are an artifact of BIOS'
> "disk geometry" description.

I know, I was speaking about physical platters of course. Mark Hann told
me in private that he disagreed with me, so I checked recent disks 
(36, 73, 147 GB SCSI with 1, 2, 4 platters) and he was right, they have
exactly the same spec concerning speed. But I said that I remember the
times when I regularly did this test on disks that I was integrating about
7-8 years ago, they were 2.1, 4.3, 6.4 GB (1,2,3 platters), and I'm fairly
certain that the 1-platter performed at about 5 MB/s while the 6.4 was around
12 MB/s. BTW, the 9GB SCSI I have in my PC does about 28 MB/s for 1 platter,
while its 18 GB equivalent (2 platters) does about 51. So I think that what
I observed remained true for such capacities, but changed on bigger disks
because of mechanical constraints. Afterall, what's 18 GB now ? Less than
one twentieth of the biggest disk.

Anyway, this is off-topic, so that's my last post on LKML on the subject.

Regards,
Willy
