Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285304AbRLSOOI>; Wed, 19 Dec 2001 09:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285303AbRLSON6>; Wed, 19 Dec 2001 09:13:58 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:31754 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S285291AbRLSONr>; Wed, 19 Dec 2001 09:13:47 -0500
Date: Wed, 19 Dec 2001 15:13:37 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Alexander Viro'" <viro@math.psu.edu>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>
Subject: Re: Booting a modular kernel through a multiple streams file
Message-ID: <20011219141337.GC1158@arthur.ubicom.tudelft.nl>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D804@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D804@orsmsx111.jf.intel.com>
User-Agent: Mutt/1.3.24i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 11:50:47AM -0800, Grover, Andrew wrote:
> > From: Alexander Viro [mailto:viro@math.psu.edu]
> > On Tue, 18 Dec 2001, Grover, Andrew wrote:
> > > GRUB 0.90 does this today.
> > ... and I'm quite sure that EMACS could do it easily.  Let's not talk
> > about GNU bloatware, OK?
> 
> I don't think this is bloatware, especially considering there really isn't
> any cost for having a full-featured bootloader - all its footprint gets
> reclaimed, after all. I respect lilo and its cousins, but they make things
> harder than they have to be. Why maintain a reduced level of functionality
> (software emaciation?) when better alternatives are available?

I think it's time to wake you up from your warm and fuzzy "all the
world is an x86" dream.

Al's initramfs works on *all* architectures, not only on an
architecture which happens to have a bootloader bloated enough to be an
operating system in itself.

Let me disturb you even further: you might think that a full featured
bootloader/firmware is a Good Thing, but in the ARM Linux world we have
learned that a simple bootloader is *much* better for maintainability.
I think the ACPI problems exactly show my point: depending on BIOS
vendors to get the ACPI tables right just doesn't work.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
