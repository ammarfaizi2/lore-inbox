Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSEDVVk>; Sat, 4 May 2002 17:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315195AbSEDVVj>; Sat, 4 May 2002 17:21:39 -0400
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:59288 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S315162AbSEDVVj>; Sat, 4 May 2002 17:21:39 -0400
Date: Sat, 4 May 2002 17:25:53 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: <linux-kernel@vger.kernel.org>
Subject: RE: IO stats in /proc/partitions
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBCEAOEMAA.znmeb@aracnet.com>
Message-ID: <Pine.LNX.4.33.0205041718290.4175-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm with Andries on this one! Linux can't survive if anyone can change it
> and break all the supporting software in user space that reads stuff from

there is no serious breakage issue, since the extra fields would
not break any competent parsing code.

> Linux has *got* to mature to the point where the documentation is *accurate*
> and *available* and the APIs don't wobble under the feet of their users. I

nah.  changing APIs and internals is exactly the reason Linux wins.

> subsystem a machine is operating. I consider the fact that I had to dig for
> and ask for this information unacceptable.

would you like that on a silver platter?

> people money. Something that wastes my time costs my employer money.

perhaps you've mistaken this for a Windows mailing list.

> On the other hand, disk statistics should not be in
> /proc/partitions. They should be in /proc/diskstatistics.

aesthetics is good, but here, what point would it serve?
tools would simply need to parse two separate files.
the point is that the files are inherently parallel.
if this aesthetic were followed, most of /proc would need to 
be transplanted into /system-info or something.  again,
serving no practical purpose.

