Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUHZBNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUHZBNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 21:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUHZBNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 21:13:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:24478 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266525AbUHZBNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 21:13:30 -0400
Date: Wed, 25 Aug 2004 18:13:26 -0700
From: Chris Wright <chrisw@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Jamie Lokier <jamie@shareable.org>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040825181326.A1973@build.pdx.osdl.net>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Thu, Aug 26, 2004 at 01:30:55AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* viro@parcelfarce.linux.theplanet.co.uk (viro@parcelfarce.linux.theplanet.co.uk) wrote:
> On Thu, Aug 26, 2004 at 01:11:52AM +0100, Jamie Lokier wrote:
> > Is this a problem if we treat entering a file-as-directory as crossing
> > a mount point (i.e. like auto-mounting)?
> 
> Yes - mountpoints can't be e.g. unlinked.

Could it be essentially MNT_DETACH'd?
