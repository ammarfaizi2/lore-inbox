Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUFEIXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUFEIXs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 04:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbUFEIXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 04:23:48 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:7618 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264562AbUFEIXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 04:23:46 -0400
Date: Sat, 5 Jun 2004 09:23:37 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Colin Leroy <colin@colino.net>
Cc: akpm@asdl.org, Michel D_nzer <michel@daenzer.net>,
       Benjamin <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sf.net
Subject: Re: [PATCH] 2.6.7-rc2: fix agpgart
In-Reply-To: <20040604213907.395b01aa@jack.colino.net>
Message-ID: <Pine.LNX.4.58.0406050921240.21707@skynet>
References: <20040604174818.03a4f795@jack.colino.net> <1086366108.4243.117.camel@localhost>
 <20040604213907.395b01aa@jack.colino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > in DRM(agp_acquire) should be removed altogether in a 2.6 kernel
> > because its vmap() takes 4 arguments; however, only the guards seem to
> > have been removed, which causes this function to erroneously fail if
> > the AGP aperture can't be directly accessed by the CPU.
>
> Looks like. Removing it fixes the problem. Here's the patch...
> Signed-off-by: Colin Leroy <colin@colino.net>
>

okay I've put this into the DRM bk tree, thanks guys, I'll push it to
Linus ASAP..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

