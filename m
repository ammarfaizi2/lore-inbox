Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316611AbSFKFDt>; Tue, 11 Jun 2002 01:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316826AbSFKFDs>; Tue, 11 Jun 2002 01:03:48 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:7927 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316611AbSFKFDr>; Tue, 11 Jun 2002 01:03:47 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 10 Jun 2002 23:02:11 -0600
To: cnliou@eurosport.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: mke2fs (and mkreiserfs) core dumps
Message-ID: <20020611050211.GU20388@turbolinux.com>
Mail-Followup-To: cnliou@eurosport.com, linux-kernel@vger.kernel.org
In-Reply-To: <200206110201.0ab3@th00.opsion.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 11, 2002  02:01 +0000, cnliou@eurosport.com wrote:
> I am exeperiencing the similar problem in kernel
> 2.4.18, glibc 2.2.5, and patched gcc 2.95.3
> (http://ricardo.ecn.wfu.edu/glib-linux-archive/0110/0
> 007.html).
> 
> Both of the following commands
> 
> mke2fs /dev/md0
> mke2fs -j /dev/md0
> 
> output
> 
> File size limit exceeded

You must log in directly at the console as root (no su or sudo), or
disable any ulimit from being set.

Alternately, if you get the very latest e2fsprogs (1.27) then it
should also be able to work around this problem.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

