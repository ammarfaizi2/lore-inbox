Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268955AbUHMDd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268955AbUHMDd1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 23:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268961AbUHMDd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 23:33:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:21940 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268955AbUHMDd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 23:33:26 -0400
Date: Thu, 12 Aug 2004 20:33:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Dilger <adilger@clusterfs.com>
cc: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Possible dcache BUG
In-Reply-To: <20040813022759.GN18216@schnapps.adilger.int>
Message-ID: <Pine.LNX.4.58.0408122033040.1839@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
 <20040808113930.24ae0273.akpm@osdl.org> <200408100012.08945.gene.heskett@verizon.net>
 <200408102342.12792.gene.heskett@verizon.net> <Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
 <20040810211849.0d556af4@laptop.delusion.de> <Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
 <Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org> <20040812180033.62b389db@laptop.delusion.de>
 <Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org> <20040813022759.GN18216@schnapps.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Aug 2004, Andreas Dilger wrote:
> 
> So putting something like the above in cache_alloc_refill() is probably
> the right thing.

Yes, that sounds about right.

		Linus
