Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132220AbRDCQUy>; Tue, 3 Apr 2001 12:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132194AbRDCQUp>; Tue, 3 Apr 2001 12:20:45 -0400
Received: from ns0.petreley.net ([64.170.109.178]:27552 "EHLO petreley.com")
	by vger.kernel.org with ESMTP id <S130317AbRDCQUk>;
	Tue, 3 Apr 2001 12:20:40 -0400
Date: Tue, 3 Apr 2001 09:19:55 -0700
From: Nicholas Petreley <nicholas@petreley.com>
To: Harald Dunkel <harri@synopsys.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS? How reliable is it? Is this the future?
Message-ID: <20010403091955.A379@petreley.com>
In-Reply-To: <3AC9BE5A.DE079EE1@Synopsys.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <3AC9BE5A.DE079EE1@Synopsys.COM>; from harri@synopsys.COM on Tue, Apr 03, 2001 at 02:13:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Linux boxes are 99% Reiserfs (I work with 2 small ext2
partitions - the rest are Reiserfs partitions).  Some things
I have noticed:

The good (2.2 kernels):

* No problems at all using Reiserfs 3.5.x on 2.2 kernels
* Speed improvements using Reiserfs and squid
* No NFS problems
* Rollback of logs is extremely fast vs. fsck

The bad (2.2 kernels)

* Nothing I can think of

The bad (2.4.x kernels):

* Some corruption problems with various 2.4.x kernels, but
people are reporting ext2 problems, too, so this is
probably due at least in part to IDE/PCI chipset issues
* Some corruption problems if an application 
uses an nfs-mounted reiserfs partition during
an unexpected shutdown of the nfs server

The good (2.4.x kernels)

* Reisefsck --rebuild-tree works fine for me
when I get corruption problems

I haven't used Windows to do any work in years.  Just
games.  

-Nick

* Harald Dunkel (harri@synopsys.COM) [010403 05:17]:
> Hi folks,
> 
> If I get the DVD stuff working, then I won't need NT anymore, i.e.
> I will have an empty disk.
> 
> What is your impression about ReiserFS? Does it work? Is it stable
> enough for my daily work, or is it something to try out and watch
> carefully? Do you use ReiserFS for your boot partition?
> 
> Or should I try ext3 instead?
> 
> 
> Regards
> 
> Harri
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
**********************************************************
Nicholas Petreley   Caldera Systems - LinuxWorld/InfoWorld
nicholas@petreley.com - http://www.petreley.com - Eph 6:12
**********************************************************
.
