Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbSJEBVv>; Fri, 4 Oct 2002 21:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261926AbSJEBVv>; Fri, 4 Oct 2002 21:21:51 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41921 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261900AbSJEBVu>;
	Fri, 4 Oct 2002 21:21:50 -0400
Date: Fri, 4 Oct 2002 21:27:24 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "David S. Miller" <davem@redhat.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: oops in bk pull (oct 03)
In-Reply-To: <20021004.181311.31550114.davem@redhat.com>
Message-ID: <Pine.GSO.4.21.0210042122400.21250-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Oct 2002, David S. Miller wrote:

> The people seeing this don't happen to be on Serverworks chipsets
> are they?
> 
> I've seen a bug on serverworks where back to back PCI config
> space operations can cause some to be lost or corrupted.

No serverwanks here.  Abit-KT7 (no RAID), VIA chipset.
 
> Another theory is that some device just dislikes being given
> a 0 in one of it's base registers, but somehow ~0 is ok :-)

... FVO some device equal to host bridge, I'm afraid.

