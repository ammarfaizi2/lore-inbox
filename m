Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316056AbSEWFoD>; Thu, 23 May 2002 01:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316067AbSEWFoD>; Thu, 23 May 2002 01:44:03 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:56059 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316056AbSEWFoC>; Thu, 23 May 2002 01:44:02 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 22 May 2002 23:42:19 -0600
To: Chris <chris@directcommunications.net>, linux-kernel@vger.kernel.org
Subject: Re: It hurts when I shoot myself in the foot
Message-ID: <20020523054219.GL458@turbolinux.com>
Mail-Followup-To: Chris <chris@directcommunications.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205221615.g4MGFCH30271@directcommunications.net> <acha7p$cge$1@cesium.transmeta.com> <20020523034821.GK458@turbolinux.com> <20020523044933.GB4006@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 22, 2002  21:49 -0700, Mike Fedyk wrote:
> On Wed, May 22, 2002 at 09:48:21PM -0600, Andreas Dilger wrote:
> > There was a kernel patch posted about 5 or so months ago which would
> > "handle" this setup (CPUs with the same clock speed, but different
> > multipliers).  Alan Cox said it probably was a bad idea, so it wouldn't
> > go into the kernel, but the patch may still be usable.
> > 
> > This is sometimes called "asymmetric multiprocessing", and the thread
> > is at http://marc.theaimsgroup.com/?l=linux-kernel&m=98519070331478&w=4
> 
> I thought asymmetric multiprocessing would support CPUs with different
> speeds.  ie, 400 & 450mhz.  How would you get different multipliers and same
> Mhz when the CPUs are on the same FSB(ignoring AMD SMP where each processor
> has an exclusive FSB, and this might be possible)?

That was what I was trying to say: same FSB speed * different multipliers
= different CPU MHZ, like what the original poster is asking about.
I don't think it is possible to configure a motherboard to have different
FSB speeds for two processors.

> There was a patch to compare the different features on the CPUs available
> and use the subset available on all processors.

Hmm, maybe if you had actually read my email and followed the URL I
posted, you would have found the patch to which you refer ;-).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

