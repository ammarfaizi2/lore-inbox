Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276361AbRKMQnx>; Tue, 13 Nov 2001 11:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276344AbRKMQno>; Tue, 13 Nov 2001 11:43:44 -0500
Received: from stine.vestdata.no ([195.204.68.10]:51334 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S275693AbRKMQnd>; Tue, 13 Nov 2001 11:43:33 -0500
Date: Tue, 13 Nov 2001 17:43:26 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org, lars.nakkerud@compaq.com
Subject: Re: Tuning Linux for high-speed disk subsystems
Message-ID: <20011113174326.A32405@vestdata.no>
In-Reply-To: <Pine.LNX.4.30.0111131519440.933-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0111131519440.933-100000@mustard.heime.net>; from roy@karlsbakk.net on Tue, Nov 13, 2001 at 03:29:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 03:29:13PM +0100, Roy Sigurd Karlsbakk wrote:
> After some testing at Compaq's lab in Oslo, I've come to the conclusion
> that Linux cannot scale higher than about 30-40MB/sec in or out of a
> hardware or software RAID-0 set with several stripe/chunk sizes tried out.

Eh, we do 60-70 MB/s reads and 110-120 MB/s writes on our RAIDs... from
linux.


> Does anyone know this stuff good enough to help me how to tune the system?
> PS: The CPUs were almost idle during the test. Tested file system was
> ext2.

I'd say you should get rid of your compaq raid controller and use a
regular SCSI-controller - 66Mhz 64 bit. (e.g. an adaptec)



-- 
Ragnar Kjørstad
Big Storage
