Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSG1TtO>; Sun, 28 Jul 2002 15:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317189AbSG1TtO>; Sun, 28 Jul 2002 15:49:14 -0400
Received: from cicero0.cybercity.dk ([212.242.40.52]:49925 "EHLO
	cicero0.cybercity.dk") by vger.kernel.org with ESMTP
	id <S317181AbSG1TtJ>; Sun, 28 Jul 2002 15:49:09 -0400
Date: Sun, 28 Jul 2002 21:00:38 +0200
From: Daniel Mose <imcol@unicyclist.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to start on new db-based FS?
Message-ID: <20020728210038.A3864@unicyclist.com>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020726160742.GA951@ksu.edu> <20020726190520.GA3192@localhost> <3D41ADD3.9010509@namesys.com> <20020727220826.A31431@unicyclist.com> <3D434CD3.7010807@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3D434CD3.7010807@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Daniel Mose wrote:
> >I'm doing a scan on the web for disk storage layout documentation on
> >different file systems. I have I think, downloaded just about all 
> >there is to download on www.namesys.com, but I fail to find anything
> >that does describe the reiserfs storage layout in any detail.
> >Is there such documentation available? 

I do believe that I've been somewhat unclear. What I would hope 
to find is :
Documentation of On-disk Per-partition storage layout 
of file lookup and maintainance structures for reiserfs. 

> >I would be very happy for directions to it in this case.
> >
> >Reason? I want to know if the root file system that I my self is 
                                 ^^^^^^^^^^^^^^^^
Correction, Should be: File system for root mountable partitions. 

> >about to develop perhaps is already implemented to some extent in
> >any existing root FS:s ? 
                ^^^^^^^^^ 
same correction here.
> 
> What is a root filesystem? (I am accustomed to the term as describing 
> what the OS uses for storing the semantic layer's root directory).

I do not have a CS - convention, or Unix background, so I am a bit
unfamiliar with terms like "semantic layer's root directory" 
I am a "learn by doing" type of guy, and up to now it has worked out
ok.

There seems to be a lot of discrepancies when it comes to 
defining what a "file system" really is. I often find that the 
term is used with widely different meanings, depending on who 
you are actually talking to, and also in what context it is used.  

I believe that the developers at www.oss.sgi, as well as the JFS 
developers hosted at IBM, use the term: "root file system" to make 
clear that 

A.	It is a Unix type of file system, that can be used as "/"
	at boot, i e a system "magically" mountable root partition.
	
B.	The file system occupies a Local mountable disk partition, 
	and is acessible via the  Unix mount command.

C.	The file system is used for file access, and maintainance of 
	On-disk	file-lookup hierarchies, such as one or more 
	Superblocks, File allocation scheemes ( f ex allocation group 
	descriptors,block and inode bitmap tables, as well as inodes )
	and Directory files ( ext2fs or FFS )

I hope that this makes a bit more sense to you.
Thank you for taking time with me, all the same

I'm happy for any further direction.

kind regards 
Daniel Mose
