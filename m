Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279981AbRLRLQE>; Tue, 18 Dec 2001 06:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280002AbRLRLPy>; Tue, 18 Dec 2001 06:15:54 -0500
Received: from pcow028o.blueyonder.co.uk ([195.188.53.124]:22541 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S279981AbRLRLPu>;
	Tue, 18 Dec 2001 06:15:50 -0500
Message-ID: <T57e612d0dbac1785e6169@pcow028o.blueyonder.co.uk>
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <james@sutherland.net>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: Tue, 18 Dec 2001 11:16:05 +0000
X-Mailer: KMail [version 1.3.1]
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0112180350550.6100-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0112180350550.6100-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 December 2001 8:55 am, Alexander Viro wrote:
> On Tue, 18 Dec 2001, James A Sutherland wrote:
> > Not necessarily. You could, say, put the modules in a small filesystem
> > image - say, Minix, or maybe ext2. Then just have the loader put that
> > disk image into RAM, and have the kernel able to read disk images from
> > RAM initially.
> >
> > Of course, this revolutionary new features needs a name. Something like
> > initrd, perhaps?
>
> Had you actually looked at initrd-related code?  I had and "bloody mess"
> is the kindest description I've been able to come up with.  Even after
> cleanups and boy, were they painful...

With a choice between that, or teaching lilo, grub etc how to link modules - 
and how to read NTFS and XFS, and losing the ability to boot from fat, minix 
etc floppies, tftp or nfs servers - almost any level of existing nastiness 
would be preferable to that sort of insane codebloat!


James.
