Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278249AbRJWUlq>; Tue, 23 Oct 2001 16:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278245AbRJWUlk>; Tue, 23 Oct 2001 16:41:40 -0400
Received: from okcforum.org ([207.43.150.207]:9229 "EHLO okcforum.org")
	by vger.kernel.org with ESMTP id <S278221AbRJWUla>;
	Tue, 23 Oct 2001 16:41:30 -0400
Message-ID: <3BD5D603.1030605@okcforum.org>
Date: Tue, 23 Oct 2001 15:41:39 -0500
From: "Nathan G. Grennan" <ngrennan@okcforum.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011018
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Filesystem/Drive problems with 2.4.12-ac4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got these at around 2:34:35 as you can see and more at 4:05:23

The kernel is 2.4.12-ac4+preemptive

I think they were started by processes called by cron to scan the 
filesystem for things like locate.
It is hard to till exactly which fat filesystem it was complaining 
about, but my best guess is my
windows c drive which is hde3. My vfat filesystems are hde3, hde4, and 
hdg1.  At first I thought
it might have been my problematic IBM DTLA-307045 45gb drive, but if it 
is hde3, it is my
brand new QUANTUM FIREBALLP AS40.0   The controller is a HPT370 running 
normally
(without a raid array) with bios version 1.2.something. The controller 
isn't using LBA with this
drive and doesn't seem to have an option to force it to use LBA. I was 
up till 3am and didn't
even notice the 2:34:35 error messages till after getting up the next 
day and checking dmesg
after having problems with rebooting thru the gnome bar. Each drive in 
my machine is set
to master and is on it's on ide port/80 wire ide cable.  Any ideas what 
caused this???

Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=361343364, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=361343365, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=361343365, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=361343366, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=361343366, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=361343367, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=361343367, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=361343368, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: Filesystem panic (dev 21:03).
Oct 23 02:34:35 cygnusx-1 kernel:   FAT error
Oct 23 02:34:35 cygnusx-1 kernel:   File system has been set read-only
Oct 23 02:34:35 cygnusx-1 kernel: Directory 64638: bad FAT
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=1690050552, 
limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=1690050553, 
limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=1690050553, 
limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=1690050554, 
limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=1690050554, 
limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=1690050555, 
limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=1690050555, 
limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=1690050556, 
limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: Filesystem panic (dev 21:03).
Oct 23 02:34:35 cygnusx-1 kernel:   FAT error
Oct 23 02:34:35 cygnusx-1 kernel: Directory 64640: bad FAT
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=769138684, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=769138685, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=769138685, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=769138686, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=769138686, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=769138687, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=769138687, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=769138688, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: Filesystem panic (dev 21:03).
Oct 23 02:34:35 cygnusx-1 kernel:   FAT error
Oct 23 02:34:35 cygnusx-1 kernel: Directory 64642: bad FAT
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=430972948, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=430972949, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=430972949, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=430972950, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=430972950, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=430972951, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=430972951, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=430972952, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: Filesystem panic (dev 21:03).
Oct 23 02:34:35 cygnusx-1 kernel:   FAT error
Oct 23 02:34:35 cygnusx-1 kernel: Directory 64651: bad FAT
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=20455548, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=20455549, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=20455549, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=20455550, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=20455550, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=20455551, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=20455551, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=20455552, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: Filesystem panic (dev 21:03).
Oct 23 02:34:35 cygnusx-1 kernel:   FAT error
Oct 23 02:34:35 cygnusx-1 kernel: Directory 64654: bad FAT
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=967894192, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=967894193, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=967894193, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=967894194, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=967894194, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=967894195, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=967894195, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=967894196, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: Filesystem panic (dev 21:03).
Oct 23 02:34:35 cygnusx-1 kernel:   FAT error
Oct 23 02:34:35 cygnusx-1 kernel: Directory 64657: bad FAT
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=769138684, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=769138685, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: attempt to acces3d03ff0) failed
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=31989752, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: Directory sread (sector 0x3d03ff0) failed
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=31989752, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: Directory sread (sector 0x3d03ff0) failed
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=31989752, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: Directory sread (sector 0x3d03ff0) failed
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=31989752, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: Directory sread (sector 0x3d03ff0) failed
Oct 23 02:34:35 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:35 cygnusx-1 kernel: 21:03: rw=0, want=31989752, limit=4194792
Oct 23 02:34:35 cygnusx-1 kernel: Directory sread (sector 0x3d03ff0) failed
Oct 23 02:34:36 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:36 cygnusx-1 kernel: 21:03: rw=0, want=31989752, limit=4194792
Oct 23 02:34:36 cygnusx-1 kernel: Directory sread (sector 0x3d03ff0) failed
Oct 23 02:34:36 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:36 cygnusx-1 kernel: 21:03: rw=0, want=31989752, limit=4194792
Oct 23 02:34:36 cygnusx-1 kernel: Directory sread (sector 0x3d03ff0) failed
Oct 23 02:34:36 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:36 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:36 cygnusx-1 kernel: 21:03: rw=0, want=31989752, limit=4194792
Oct 23 02:34:36 cygnusx-1 kernel: Directory sread (sector 0x3d03ff0) failed
Oct 23 02:34:36 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:36 cygnusx-1 kernel: 21:03: rw=0, want=31989752, limit=4194792
Oct 23 02:34:36 cygnusx-1 kernel: Directory sread (sector 0x3d03ff0) failed
Oct 23 02:34:36 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:36 cygnusx-1 kernel: 21:03: rw=0, want=31989752, limit=4194792
Oct 23 02:34:36 cygnusx-1 kernel: Directory sread (sector 0x3d03ff0) failed
Oct 23 02:34:36 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:36 cygnusx-1 kernel: 21:03: rw=0, want=31989752, limit=4194792
Oct 23 02:34:36 cygnusx-1 kernel: Directory sread (sector 0x3d03ff0) failed
Oct 23 02:34:36 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:36 cygnusx-1 kernel: 21:03: rw=0, want=31989752, limit=4194792
Oct 23 02:34:36 cygnusx-1 kernel: Directory sread (sector 0x3d03ff0) failed
Oct 23 02:34:36 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:36 cygnusx-1 kernel: 21:03: rw=0, want=31989753, limit=4194792
Oct 23 02:34:36 cygnusx-1 kernel: Directory sread (sector 0x3d03ff1) failed
Oct 23 02:34:36 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:36 cygnusx-1 kernel: 21:03: rw=0, want=31989753, limit=4194792
Oct 23 02:34:36 cygnusx-1 kernel: Directory sread (sector 0x3d03ff1) failed
Oct 23 02:34:36 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:36 cygnusx-1 kernel: 21:03: rw=0, want=31989753, limit=4194792
Oct 23 02:34:36 cygnusx-1 kernel: Directory sread (sector 0x3d03ff1) failed
Oct 23 02:34:36 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:36 cygnusx-1 kernel: 21:03: rw=0, want=31989753, limit=4194792
Oct 23 02:34:36 cygnusx-1 kernel: Directory sread (sector 0x3d03ff1) failed
Oct 23 02:34:36 cygnusx-1 kernel: attempt to access beyond end of device
Oct 23 02:34:36 cygnusx-1 kernel: 21:03: rw=0, want=31989753, limit=4194792
Oct 23 02:34:36 cygnusx-1 kernel: Directory sread (sector 0x3d03ff1) failed
Oct 23 02:34:36 cygnusx-1 kernel: attempt to access beyond end of device


