Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316828AbSFKFQe>; Tue, 11 Jun 2002 01:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316831AbSFKFQe>; Tue, 11 Jun 2002 01:16:34 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:9207 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316828AbSFKFQd>; Tue, 11 Jun 2002 01:16:33 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 10 Jun 2002 23:14:53 -0600
To: Simon Matthews <simon@paxonet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS Client mis-behaviour?
Message-ID: <20020611051453.GV20388@turbolinux.com>
Mail-Followup-To: Simon Matthews <simon@paxonet.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206102041020.11116-100000@spare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 10, 2002  20:48 -0700, Simon Matthews wrote:
> I have seen some strange behaviour from the NFS client. 

Sorry, can't help with the NFS problem.

> We installed a new machine, 2 x 2.2GHz Xeon processors
> 
> Another question: this system has 2 CPUs, yet the kernel detects 4. Any 
> ideas why? 

Probably because they are "Hyper Threaded" (HT) CPUs, which means they
have (almost) 2 CPU cores per chip.  The second core is not a full CPU,
so it is not as fast as running a 4 CPU system, but reports are about
30% faster than just 2 CPUs.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

