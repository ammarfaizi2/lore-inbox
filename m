Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314650AbSEKGR6>; Sat, 11 May 2002 02:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314613AbSEKGR5>; Sat, 11 May 2002 02:17:57 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:42625 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314468AbSEKGR5>;
	Sat, 11 May 2002 02:17:57 -0400
Date: Sat, 11 May 2002 02:17:50 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: Re: [PATCH] devfs v212 available
In-Reply-To: <200205110608.g4B68re24563@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0205110213300.20383-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 May 2002, Richard Gooch wrote:

> This is against 2.5.14. Highlights of this release:
> 
> - Added BKL to <devfs_open> because drivers still need it

Sigh...  Look at the callers of check_disc_changed() and check what's
going on with traversing directory contents there.

