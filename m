Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUIDSGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUIDSGQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 14:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUIDSGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 14:06:16 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:50192 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265264AbUIDSDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 14:03:36 -0400
Message-ID: <9e473391040904110354ba2593@mail.gmail.com>
Date: Sat, 4 Sep 2004 14:03:26 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Keith Whitwell <keith@tungstengraphics.com>
Subject: Re: New proposed DRM interface design
Cc: Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       mharris@redhat.com
In-Reply-To: <4139FEB4.3080303@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040904102914.B13149@infradead.org>
	 <4139995E.5030505@tungstengraphics.com>
	 <20040904112930.GB2785@redhat.com>
	 <4139A9F4.4040702@tungstengraphics.com>
	 <20040904115442.GD2785@redhat.com>
	 <4139B03A.6040706@tungstengraphics.com>
	 <20040904122057.GC26419@redhat.com>
	 <4139C8A3.6010603@tungstengraphics.com>
	 <9e47339104090408362a356799@mail.gmail.com>
	 <4139FEB4.3080303@tungstengraphics.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Sep 2004 18:43:16 +0100, Keith Whitwell
<keith@tungstengraphics.com> wrote:
> > You may think that X on GL (gnuLonghorn) is a crazy idea. But
> > comptetive pressures from the Mac and Longhhorn will force us into
> > doing it so or later. I'd rather do it sooner.
> >
> 
> Not a crazy idea at all, plus I like the name.  But a fork could help relieve
> the tension between trying to maintain a stable DRM and the sorts of stuff
> that you need to do to move to the next level.  And I recognize that I get
> grumpy when it sounds like existing functionality is threatened by your desire
> to push off in a certain technical direction.  If gnuLonghorn/DRM makes a
> friendly/development fork off the existing DRM, things might go a little smoother.

I'm sure we'll get a cease and desist letter from Microsoft if we call
it gnuLonghorn.

Here's a completely different tack on the same problem. As I
understand things it would be better for DRM if DRM merged into the
Linux kernel tree/development process. Given that this is true for
Linux it is probably true for BSD too.

Developers hold the copyrights on their patches. We could mark each
patch going into Linux DRM as being BSD or GPL licensed. For example I
could add a bunch of existing fbdev code in a patch marked GPL. I
could then add the code for integrating it and making it work and mark
it as BSD. This scheme lets the BSD people extract driver changes out
of the Linux code base without licensing problems. The BSD marked
patches don't bother Linux since the BSD license is upwardly
compatible to GPL.

This does add some work to the BSD developers but it would make all of
the new code that doesn't copy preexisting GPL code fair game. I have
no problem marking any new code I write as being BSD licensed, I just
don't want to rewrite 80,000 lines of fbdev code.
