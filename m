Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUIDVHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUIDVHN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 17:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUIDVHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 17:07:12 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:16080 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266195AbUIDVGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 17:06:52 -0400
Subject: Re: New proposed DRM interface design
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Airlie <airlied@linux.ie>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409041151200.25475@skynet>
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com>
	 <Pine.LNX.4.58.0409040145240.25475@skynet>
	 <20040904102914.B13149@infradead.org>
	 <41398EBD.2040900@tungstengraphics.com>
	 <20040904104834.B13362@infradead.org>
	 <413997A7.9060406@tungstengraphics.com>
	 <20040904112535.A13750@infradead.org>
	 <4139995E.5030505@tungstengraphics.com> <41399CA2.3080607@yahoo.com.au>
	 <Pine.LNX.4.58.0409041151200.25475@skynet>
Content-Type: text/plain
Message-Id: <1094332018.6575.329.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 04 Sep 2004 17:06:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-04 at 06:54, Dave Airlie wrote:
> >
> > Just out of interest, what would the scenario be if you do if you could
> > get a compatible driver?
> 
> It's one of the major successes I feel of the DRI project, those
> snapshots allowed people with Radeon IGP chipsets to get 3d acceleration
> long before now (they still can't get it any current distro), same goes
> for i915 as Keith points out..
> 

OK, please explain how I install the latest Unichrome DRI driver.  The
docs at the unichrome site are correct except they refer to this guide
which is out of date:

http://dri.sourceforge.net/cgi-bin/moin.cgi/Building

How do you expect users to 'just grab the new release' if *your own user
documentation* is incorrect (from the above page):

  NOTE that these instructions may be out of date. According to 
  http://sourceforge.net/mailarchive/message.php?msg_id=9295537 
  parts of DRI have moved to a new repository. 
        
        "Mesa and DRM are still in the same repositories on
        freedesktop.org. But the DRI enabled DDX drivers are now
        developped in Xorg CVS instead of DRI CVS. See
        http://xorg.freedesktop.org for details." 
        
Wow, thanks, that explains everything!

This should not be hard.  I have built and installed Xorg from CVS.  I
know what I am doing.  What the heck is a non-coder supposed to do?

All I need is to figure out how to build unichrome_dri.so.  There seems
to be a unichrome directory in the Xorg, Mesa, and DRI CVS trees.  I
should just be able to cd to this directory and type make or make
unichrome_dri.so or something, just like I do to install the via DRI
kernel module, or ALSA modules, or any other kernel module with a
reasonable build process.  Does not work.

If someone tells me how to do this I promise to post a HOWTO.

Lee
        
         

