Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315922AbSEWDtx>; Wed, 22 May 2002 23:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315924AbSEWDtw>; Wed, 22 May 2002 23:49:52 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:18427 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S315922AbSEWDtw>; Wed, 22 May 2002 23:49:52 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 22 May 2002 21:48:21 -0600
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: It hurts when I shoot myself in the foot
Message-ID: <20020523034821.GK458@turbolinux.com>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205221615.g4MGFCH30271@directcommunications.net> <acha7p$cge$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 22, 2002  16:39 -0700, H. Peter Anvin wrote:
> Followup to:  <200205221615.g4MGFCH30271@directcommunications.net>
> By author:    Chris <chris@directcommunications.net>
> In newsgroup: linux.dev.kernel
> > 
> > I looked inside the box and found a Pentium II 400, and a Pentium II 450.
> > 
> > Oddly enough they run together as a 266.
> 
> The fact that they have different BogoMIPS figures indicate that that
> is not really the case.  It looks more like the second processor is
> running at 333 MHz or something.  You definitely have a bizarre box
> here, and you probably should be running with the "notsc" option.
> Heck, maybe you can reconfigure your mobo and actually run both
> processors at 400 MHz.  You'd get quite a performance boost, too...

There was a kernel patch posted about5 or so months ago which would
"handle" this setup (CPUs with the same clock speed, but different
multipliers).  Alan Cox said it probably was a bad idea, so it wouldn't
go into the kernel, but the patch may still be usable.

This is sometimes called "asymmetric multiprocessing", and the thread
is at http://marc.theaimsgroup.com/?l=linux-kernel&m=98519070331478&w=4

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

