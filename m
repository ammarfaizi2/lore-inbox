Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284752AbRLRTqZ>; Tue, 18 Dec 2001 14:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284911AbRLRTpI>; Tue, 18 Dec 2001 14:45:08 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:9939 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S284860AbRLRToS>;
	Tue, 18 Dec 2001 14:44:18 -0500
Date: Tue, 18 Dec 2001 20:43:53 +0100
From: David Weinehall <tao@acc.umu.se>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'James A Sutherland'" <james@sutherland.net>,
        Alexander Viro <viro@math.psu.edu>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Booting a modular kernel through a multiple streams file
Message-ID: <20011218204353.R5235@khan.acc.umu.se>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D803@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D803@orsmsx111.jf.intel.com>; from andrew.grover@intel.com on Tue, Dec 18, 2001 at 09:47:58AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 09:47:58AM -0800, Grover, Andrew wrote:
> > From: James A Sutherland [mailto:james@sutherland.net]
> > > Had you actually looked at initrd-related code?  I had and 
> > "bloody mess"
> > > is the kindest description I've been able to come up with.  
> > Even after
> > > cleanups and boy, were they painful...
> > 
> > With a choice between that, or teaching lilo, grub etc how to 
> > link modules - 
> > and how to read NTFS and XFS, and losing the ability to boot 
> > from fat, minix 
> > etc floppies, tftp or nfs servers - almost any level of 
> > existing nastiness 
> > would be preferable to that sort of insane codebloat!
> 
> 1) GRUB can already do this
> 2) Each bootloader doesn't need to link, the kernel includes the linker.
> (which after it does its job can be discarded and insmod used later on)
> 3) Seeing how ugly everyone seems to think initrd is, this seems like a
> worthwhile option to consider.

And GRUB is of course available for all platforms that Linux is
available for? Noooo? I didn't think so...


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
