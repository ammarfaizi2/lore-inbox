Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287983AbSABXdf>; Wed, 2 Jan 2002 18:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288002AbSABXbu>; Wed, 2 Jan 2002 18:31:50 -0500
Received: from sweetums.bluetronic.net ([66.57.88.6]:33416 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S288018AbSABXa1>; Wed, 2 Jan 2002 18:30:27 -0500
Date: Wed, 2 Jan 2002 18:30:13 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Brian <hiryuu@envisiongames.net>
cc: Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Two hdds on one channel - why so slow?
In-Reply-To: <0GPB00E6IVBF4D@mtaout45-01.icomcast.net>
Message-ID: <Pine.GSO.4.33.0201021812560.28783-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Brian wrote:
>> Also under a similar environment, I was able to, using a single card, 4
>> drives, not hardware-raid, no caching controller, reach 90MB/sec writing
>> and reading was about 78MB/sec.
>
>4 drives on two chains (master & slave on each) is certainly more
>interesting.  The write speed is impressive, but what cut the read
>performance in half?

I'd take those numbers with a very large grain of salt.  The fastest drives
in existance have a ZBR @ slightly half those numbers (and they are all SCSI,
btw.)  Thus, your math is wrong or there is some serious voodoo going down.
(I'll have someone check for chicken blood.)

On price alone, SCSI has always lost.  However, IDE has always been inferior.
No disconnect/reconnect.  No tagged command queing.  No linked commands.  Very
small addressable space.  Etc.  After a decade, IDE is now beginning to add
all those things SCSI has had for years. (They started using the SCSI command
protocol several years ago -- "ATAPI")

IDE is just fine for toys.  It's a serious pain in the ass for any serious
work.  It takes expensive hardware RAID cards to make IDE tolerable. (and
I'm not talking about the 30$ PoS HPT crap.)

--Ricky

PS: I once turned down a 360MHz Ultra10 in favor of a 167MHz Ultra1 because
    of the absolutely shitty IDE performance.  The U1 was actually faster
    at compiling software. (Solaris 2.6, btw)


