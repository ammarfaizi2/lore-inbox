Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269906AbUIDMBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269906AbUIDMBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 08:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269910AbUIDMBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 08:01:08 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:37833 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S269906AbUIDLzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:55:22 -0400
Date: Sat, 4 Sep 2004 12:54:42 +0100
From: Dave Jones <davej@redhat.com>
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904115442.GD2785@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
	dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com> <4139A9F4.4040702@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4139A9F4.4040702@tungstengraphics.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 12:41:40PM +0100, Keith Whitwell wrote:

 > > > >Download a new kernel.org kernel or petition the fedora legacy folks to
 > > > >include a drm update.  The last release RH-9 kernel has various 
 > > security
 > > > >and data integrity issues anyway, so you'd be a fool to keep running 
 > > it.
 > > > 
 > > > OK, I've found www.kernel.org, and clicked on the 'latest stable 
 > > kernel' > link. I got a file called "patch-2.6.8.1.bz2".  I tried to 
 > > install this >  but nothing happened.  My i915 still doesn't work.  What 
 > > do I do now?
 > >
 > >Tungsten might like to think your end users are morons, but we like to
 > >believe our end-users (ie, ANYONE building their own kernel) have
 > >a small amount of common sense. 
 > 
 > Please don't think that I'm talking for Tungsten at this or any other time 
 > on the DRI list.  I'm talking for myself and have never attempted to convey 
 > here or elsewhere a "company" view without explictly flagging it up as 
 > such. Apologies if the use of a TG mailing address is confusing, but I will 
 > have to continue using it for the meantime as it is the one subscribed to 
 > this list.
 > 
 > Likewise, are you making a RedHat statement that you believe that your 
 > endusers need to be able to compile a kernel to use your products, or is 
 > that a statement of a regular LK developer?  I'm sure you appreciate the 
 > parallel.

If you follow the thread back, YOU were the one who decided to choose
compiling a new kernel. Christoph presented the options.
- do it yourself
- ask the fedora legacy folks to do an upgrade kernel with a new drm.
There's also a third option
- Upgrade your distro to something more recent.

And yes, I stand by these points with my Red Hat on.

 > But in general, yes, I'd like to think that you don't have to have even 
 > heard of a compiler in order to be able to install a video driver...
 > 
 > I don't see why installing a DRI driver should be more difficult than 
 > installing an NV, ATI or even a windows driver...

There's already a per-distro mechanism to make all this all nice and
transparent to end-users.  In Fedora, we even have 3 (apt-get/yum/up2date).
The problem is when 3rd parties like the DRI project expect users not to
use the tools they are familiar with, and expect them to run off to fetch
bits from websites and replace random bits of their system.

Who do you think gets the support calls and blame when the X server breaks
because the user bodged it ?

 > I don't see why it should be necessary to reboot a machine just to update 
 > it's video driver...

Thats a different kettle of fish. One day we might have an answer for
that (look up kexec if you're interested).

		Dave

