Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318116AbSHQSZT>; Sat, 17 Aug 2002 14:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318124AbSHQSZT>; Sat, 17 Aug 2002 14:25:19 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:9204 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318116AbSHQSZR>; Sat, 17 Aug 2002 14:25:17 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sat, 17 Aug 2002 12:26:38 -0600
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: aia21@cantab.net, axboe@suse.de, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, m.c.p@wolk-project.de,
       torvalds@transmeta.com
Subject: Re: IDE?
Message-ID: <20020817182638.GP9642@clusterfs.com>
Mail-Followup-To: "Adam J. Richter" <adam@yggdrasil.com>, aia21@cantab.net,
	axboe@suse.de, B.Zolnierkiewicz@elka.pw.edu.pl,
	linux-kernel@vger.kernel.org, m.c.p@wolk-project.de,
	torvalds@transmeta.com
References: <200208171302.GAA07962@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208171302.GAA07962@adam.yggdrasil.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 17, 2002  06:02 -0700, Adam J. Richter wrote:
> 	I just looked at the patch to switch to "2.4 forward port"
> version of drivers/ide.  If I got my shell commands right, Martin's
> tree is 8606 lines shorter than the 2.4 forward port.
> 
> 	2.4 forward port	49,205 lines
> 	Martin's version	40,599 lines
> 				------------
> 				 8,606 lines difference
> 
> 	It's often amazing how much cleaning up it takes to shrink
> code a little bit.  Shrinking the IDE tree this much is a lot of
> work to throw away.
> 
> 	In comparison, I think Niklaus Wirth's Modula-2 compiler for
> the Lilith machine was 5,000 lines.
> 
> 	Is the 2.5.31 IDE tree that buggy?  I would hope that stamping
> out bugs from Martin's tree would be less work than cleaning up
> the 2.4 version to that point again.

Why don't we just start with the now-discarded 2.5 IDE code as IDE-TNG?
If people want to develop/hack then they can use that, and if they
want to hack on other things they use the old code.  You just need to
make the two config options mutually exclusive until the drivers learn
to play well together (by being able to control separate drives/ctrlr).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

