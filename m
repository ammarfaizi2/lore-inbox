Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269063AbUHZPmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269063AbUHZPmD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 11:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269065AbUHZPl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 11:41:59 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:46792 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S269063AbUHZPlx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 11:41:53 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16686.1216.77602.380618@thebsh.namesys.com>
Date: Thu, 26 Aug 2004 19:41:52 +0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Christophe Saout <christophe@saout.de>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826150434.GF5733@mail.shareable.org>
References: <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
	<20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org>
	<20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk>
	<20040826001152.GB23423@mail.shareable.org>
	<20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk>
	<20040826010049.GA24731@mail.shareable.org>
	<412DA40B.5040806@namesys.com>
	<20040826140500.GA29965@fs.tum.de>
	<1093530313.11694.56.camel@leto.cs.pocnet.net>
	<20040826150434.GF5733@mail.shareable.org>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier writes:
 > Christophe Saout wrote:
 > > What reiser4 can do, but the VFS can't is to insert or remove data in
 > > the middle of a file. Adding this above the page cache would probably be
 > > almost impossible (truncate seems already complicated enough).
 > 
 > That would be one of those "special features" that a
 > VFS-plus-userspace implementation of archive views could take
 > advantage of on reiser4, while using a slower method (sometimes much
 > slower) on all other filesystems.
 > 
 > By the way, can reiser4 share parts of files between different files?

It can, but fsck is supposed to cope with this. :)

 > 
 > -- Jamie

Nikita.

