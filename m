Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268985AbUHZOMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268985AbUHZOMZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268975AbUHZOIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:08:53 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46584 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268928AbUHZOFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:05:07 -0400
Date: Thu, 26 Aug 2004 16:05:01 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Jamie Lokier <jamie@shareable.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826140500.GA29965@fs.tum.de>
References: <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk> <20040826010049.GA24731@mail.shareable.org> <412DA40B.5040806@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412DA40B.5040806@namesys.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 01:49:15AM -0700, Hans Reiser wrote:
> Jamie Lokier wrote:
> 
> >One of the big potential uses for file-as-directory is to go inside
> >archive files, ELF files, .iso files and so on in a convenient way.
> > 
> >
> Yes, this was part of the plan, tar file-directory plugins would be cute.

Silly question:

GNU Midnight Commander allows for ages to go into e.g. tar files, so I 
know the benefits of this. Additionally, in GNU Midnight Commander, this 
works no matter which file system I use (e.g. it works on iso9660), and 
it even works the same way on other OS's like e.g. Solaris and NetBSD.

What is the technical reason why a tar plugin should be reiser4 
specific, instead of a generic VFS or userspace solution that would 
allow the same also on other fs like e.g. iso9660?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

