Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262096AbSIYUbB>; Wed, 25 Sep 2002 16:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262122AbSIYUbB>; Wed, 25 Sep 2002 16:31:01 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:495 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262096AbSIYUbA>; Wed, 25 Sep 2002 16:31:00 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 25 Sep 2002 14:34:14 -0600
To: tytso@mit.edu
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020925203414.GF22795@clusterfs.com>
Mail-Followup-To: tytso@mit.edu, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17uINs-0003bG-00@think.thunk.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 25, 2002  16:03 -0400, tytso@mit.edu wrote:
> This patch significantly increases the speed of using large directories.
> Creating 100,000 files in a single directory took 38 minutes without
> directory indexing... and 11 seconds with the directory indexing turned on.

Not mentioned, but very important to note is that the dir indexing code
is 100% compatible with older kernels (even back to 1.2 days) for both
read and write.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

