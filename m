Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSFLUuw>; Wed, 12 Jun 2002 16:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSFLUuv>; Wed, 12 Jun 2002 16:50:51 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:9967 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313867AbSFLUuv>; Wed, 12 Jun 2002 16:50:51 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 12 Jun 2002 14:49:18 -0600
To: Peter Bornemann <eduard.epi@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] in page_alloc.c in 2.4.19-pre10aa2
Message-ID: <20020612204918.GC682@clusterfs.com>
Mail-Followup-To: Peter Bornemann <eduard.epi@t-online.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206122202110.11557-100000@eduard.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 12, 2002  22:26 +0200, Peter Bornemann wrote:
> Besides the aa-patches there were no other patches in the kernel but
> only the Nvidia-driver, which does not seem to be involved, however.

Please reproduce the error without the nvidia driver loaded, or report
the problem to the nvidia developers.  Unfortunately it is impossible
to say what the source of the problem is, as it is possible the nvidia
driver is overwriting memory elsewhere in the kernel and there is no
way for anyone to check that.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

