Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283340AbRL1APd>; Thu, 27 Dec 2001 19:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283390AbRL1APY>; Thu, 27 Dec 2001 19:15:24 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:42233 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S283340AbRL1APN>;
	Thu, 27 Dec 2001 19:15:13 -0500
Date: Thu, 27 Dec 2001 17:14:37 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Dave Jones <davej@suse.de>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Steven Walter <srwalter@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
Message-ID: <20011227171437.P12868@lynx.no>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Steven Walter <srwalter@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011227163130.N12868@lynx.no> <Pine.LNX.4.33.0112280043080.15706-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.33.0112280043080.15706-100000@Appserv.suse.de>; from davej@suse.de on Fri, Dec 28, 2001 at 12:51:56AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 28, 2001  00:51 +0100, Dave Jones wrote:
> On Thu, 27 Dec 2001, Andreas Dilger wrote:
> > common directories like drivers/net/foo.c.  In the top-level MAINTAINER
> > file would only be something like "Marcello Tosatti" to cover the
> > entire tree, and e.g. "David Miller" in the net/MAINTAINER, "Al Viro" in
> > the fs/MAINTAINER, "Stephen Tweedie" in fs/ext3/MAINTAINER, etc.
> 
> Indeed, this solves the keeping the list up to date with whats
> in the tree, and has provision for arbitary numbers of METOO:
> fields (Though that could get messy, whats to stop Linus getting bombed
> with a zillion additions from people who just want to get their
> name in a kernel tarball for free). One way could be approval from
> the actual maintainer "Yes, he's sent lots of patches, add him to
> METOO:".

I'd rather avoid having Linus become a human mailing-list administrator.

Rather, the "METOO" section would be handled by just adding a mailing
list address in the relevant MAINTAINER file.  The above examples would
be covered by linux-kernel, linux-net, linux-fsdevel, and ext2-devel.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

