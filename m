Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTKGFnL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 00:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263886AbTKGFnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 00:43:11 -0500
Received: from fep06-0.kolumbus.fi ([193.229.0.57]:3960 "EHLO
	fep06-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S263871AbTKGFnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 00:43:09 -0500
Date: Fri, 7 Nov 2003 07:43:13 +0200 (MET DST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
X-X-Sender: szaka@ua178d119.elisa.omakaista.fi
To: Nathan Scott <nathans@sgi.com>
cc: Maciej Zenczykowski <maze@cela.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: undo an mke2fs !!
In-Reply-To: <20031107050037.GI782@frodo>
Message-ID: <Pine.LNX.4.58.0311070715230.10194@ua178d119.elisa.omakaista.fi>
References: <Pine.LNX.4.44.0311061753350.21501-100000@gaia.cela.pl>
 <Pine.LNX.4.58.0311070601380.10194@ua178d119.elisa.omakaista.fi>
 <20031107050037.GI782@frodo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Nov 2003, Nathan Scott wrote:
> On Fri, Nov 07, 2003 at 06:35:03AM +0200, Szakacsits Szabolcs wrote:
> > On Thu, 6 Nov 2003, Maciej Zenczykowski wrote:
> > 
> > > So anything like e2image available for reiserfs?
> > 
> > AFAIK, no for other filesystems (saving only metadata), only for NTFS
> > (e2image gave the inspiration):
> 
> SEE ALSO
> xfs_copy(8).

I know xfs_copy (it's my preferred fs in the last 6+ years) but the last
time I checked it (before I sent my earlier email) it couldn't copy only
metadata as e2image (always) and ntfsclone (optionally) can do:

	http://oss.sgi.com/projects/xfs/manpages/xfs_copy.html

If it also can then the man page might be updated.

	Szaka
