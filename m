Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268718AbUHZLJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268718AbUHZLJj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268580AbUHZLFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:05:51 -0400
Received: from mail.shareable.org ([81.29.64.88]:61637 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S268704AbUHZLDJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:03:09 -0400
Date: Thu, 26 Aug 2004 12:02:58 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826110258.GC30449@mail.shareable.org>
References: <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk> <20040826010049.GA24731@mail.shareable.org> <20040826100530.GA20805@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826100530.GA20805@taniwha.stupidest.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Thu, Aug 26, 2004 at 02:00:49AM +0100, Jamie Lokier wrote:
> 
> > One of the big potential uses for file-as-directory is to go inside
> > archive files, ELF files, .iso files and so on in a convenient way.
> 
> Arguably this belongs in userspace --- and people have put it there.

I agree that these belong in userspace, and that there's plenty* of
userspace code doing a similar thing already.  I don't think there's
any argument over it.

However, as far as I know it's not accessible in a file-as-directory
form as yet.  In my opinion that is the most natural form and it would
be very intuitive to use.  I hope we can pick a useful semantics for
them, and also provide filesystem-independent plugins with GNU
Hurd-like per-user extensibility.

-- Jamie

* plenty == too much.
  Gnome, KDE, Emacs and Bash all see different virtual filesystems.
  (All but Bash implement their own virtual filesystem extensions).
  That makes them much less useful than they could be.
