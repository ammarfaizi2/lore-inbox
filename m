Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314690AbSEHQt3>; Wed, 8 May 2002 12:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314702AbSEHQt2>; Wed, 8 May 2002 12:49:28 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:38648 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S314690AbSEHQt1>; Wed, 8 May 2002 12:49:27 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 8 May 2002 10:47:49 -0600
To: "J. Albers" <j_albers@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernelpatch: multi line string problem in 2.5.14 with gcc3.x
Message-ID: <20020508164749.GD27824@turbolinux.com>
Mail-Followup-To: "J. Albers" <j_albers@web.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205080845.31655.j_albers@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 08, 2002  08:45 -0700, J. Albers wrote:
> this patches fix problems with multi line stings in 2.5.14 /w gcc 3.x

Two things:
1) your mail program is wrapping long lines
2) you need to add explicit linefeeds if you are concatenating the long
   strings (i.e. "options string.\n" "   verbose ..."

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

