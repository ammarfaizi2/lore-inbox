Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283054AbRL0XwU>; Thu, 27 Dec 2001 18:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283223AbRL0XwK>; Thu, 27 Dec 2001 18:52:10 -0500
Received: from ns.suse.de ([213.95.15.193]:22538 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S283054AbRL0Xv5>;
	Thu, 27 Dec 2001 18:51:57 -0500
Date: Fri, 28 Dec 2001 00:51:56 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Steven Walter <srwalter@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
In-Reply-To: <20011227163130.N12868@lynx.no>
Message-ID: <Pine.LNX.4.33.0112280043080.15706-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Andreas Dilger wrote:

> common directories like drivers/net/foo.c.  In the top-level MAINTAINER
> file would only be something like "Marcello Tosatti" to cover the
> entire tree, and e.g. "David Miller" in the net/MAINTAINER, "Al Viro" in
> the fs/MAINTAINER, "Stephen Tweedie" in fs/ext3/MAINTAINER, etc.

Indeed, this solves the keeping the list up to date with whats
in the tree, and has provision for arbitary numbers of METOO:
fields (Though that could get messy, whats to stop Linus getting bombed
with a zillion additions from people who just want to get their
name in a kernel tarball for free). One way could be approval from
the actual maintainer "Yes, he's sent lots of patches, add him to
METOO:".

It does seem a little messy having them scattered all over the tree
too. Extending top-level MAINTAINERS to add necessary fields could
also be done I suppose.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

