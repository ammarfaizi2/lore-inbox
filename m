Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284518AbRLRSlo>; Tue, 18 Dec 2001 13:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284537AbRLRSke>; Tue, 18 Dec 2001 13:40:34 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:2264 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S284538AbRLRSjd>; Tue, 18 Dec 2001 13:39:33 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D803@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'James A Sutherland'" <james@sutherland.net>,
        Alexander Viro <viro@math.psu.edu>
Cc: "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Booting a modular kernel through a multiple streams file
Date: Tue, 18 Dec 2001 09:47:58 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: James A Sutherland [mailto:james@sutherland.net]
> > Had you actually looked at initrd-related code?  I had and 
> "bloody mess"
> > is the kindest description I've been able to come up with.  
> Even after
> > cleanups and boy, were they painful...
> 
> With a choice between that, or teaching lilo, grub etc how to 
> link modules - 
> and how to read NTFS and XFS, and losing the ability to boot 
> from fat, minix 
> etc floppies, tftp or nfs servers - almost any level of 
> existing nastiness 
> would be preferable to that sort of insane codebloat!

1) GRUB can already do this
2) Each bootloader doesn't need to link, the kernel includes the linker.
(which after it does its job can be discarded and insmod used later on)
3) Seeing how ugly everyone seems to think initrd is, this seems like a
worthwhile option to consider.

Regards -- Andy
