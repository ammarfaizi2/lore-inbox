Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269899AbUIDLe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269899AbUIDLe2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269900AbUIDLba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:31:30 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:57032 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267686AbUIDLaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:30:20 -0400
Date: Sat, 4 Sep 2004 12:29:30 +0100
From: Dave Jones <davej@redhat.com>
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904112930.GB2785@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
	dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4139995E.5030505@tungstengraphics.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 11:30:54AM +0100, Keith Whitwell wrote:

 > >>Sure, explain to me how I should upgrade my RH-9 system to work on my new 
 > >>i915?
 > >
 > >Download a new kernel.org kernel or petition the fedora legacy folks to
 > >include a drm update.  The last release RH-9 kernel has various security
 > >and data integrity issues anyway, so you'd be a fool to keep running it.
 > 
 > OK, I've found www.kernel.org, and clicked on the 'latest stable kernel' 
 > link. I got a file called "patch-2.6.8.1.bz2".  I tried to install this 
 >  but nothing happened.  My i915 still doesn't work.  What do I do now?

Tungsten might like to think your end users are morons, but we like to
believe our end-users (ie, ANYONE building their own kernel) have
a small amount of common sense.  For those that find themselves lacking
in this area, they can usually buy some by using a vendor kernel.

If you believe that end-users aren't smart enough to figure out where to
get a kernel with all the bits they need, what makes you think they're
smart enough to figure out they need to grab the dri bits from the dri
sourceforge site (or wherever the hell they are) ?

For the record, the dri part is all thats missing in 2.6.8.1
Had it been merged sooner[1], it would work out of the box today with
that file that you downloaded. The AGPGART support for i915 has been
there for ages.

		Dave

