Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSFDDyw>; Mon, 3 Jun 2002 23:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSFDDyv>; Mon, 3 Jun 2002 23:54:51 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:55032 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316210AbSFDDyv>; Mon, 3 Jun 2002 23:54:51 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 3 Jun 2002 21:53:17 -0600
To: Austin Gonyou <austin@coremetrics.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Max groups at 32?
Message-ID: <20020604035317.GL18668@turbolinux.com>
Mail-Followup-To: Austin Gonyou <austin@coremetrics.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1023161504.4595.5.camel@UberGeek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 03, 2002  22:31 -0500, Austin Gonyou wrote:
> I'm not sure if this is a Linux capabilities problem, a PAM problem, or
> what, but I've noticed that If I add a user to > 32 groups...that user
> cannot access anything in a directory owned by a group > the 32nd group.

This is a kernel/glibc limit.  If you need complicated permissions like
this, you may want to consider using ACLs (see http://acl.bestbits.at/
for ext2/ext3/XFS ACL patches, I don't think Reiserfs has any ACL
support).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

