Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269181AbUHZR74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269181AbUHZR74 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269234AbUHZR7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:59:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42707 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269181AbUHZRyj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:54:39 -0400
Date: Thu, 26 Aug 2004 18:54:38 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, Alex Zarochentsev <zam@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826175438.GW21964@parcelfarce.linux.theplanet.co.uk>
References: <20040825205149.GA17654@lst.de> <412DA2CF.2030204@namesys.com> <20040826124119.GA431@lst.de> <20040826134812.GB5733@mail.shareable.org> <20040826155744.GA4250@lst.de> <20040826160638.GJ5733@mail.shareable.org> <20040826161303.GA4716@lst.de> <Pine.LNX.4.58.0408260919380.2304@ppc970.osdl.org> <20040826172029.GP5733@mail.shareable.org> <Pine.LNX.4.58.0408261021250.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408261021250.2304@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 10:29:45AM -0700, Linus Torvalds wrote:
> >         /dev/hda/part1/ <- the filesystem inside partition 1
> 
> I don't think you can do that. The kernel has no idea how to mount the
> filesystem.

... and what's more, fundamental thing for mount is fs type, what to
do with device(s) (if any) and any other arguments is the filesystem's
business.
