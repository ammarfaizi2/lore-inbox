Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262606AbTCIUVL>; Sun, 9 Mar 2003 15:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262607AbTCIUVK>; Sun, 9 Mar 2003 15:21:10 -0500
Received: from mailhost.tue.nl ([131.155.2.4]:53255 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S262606AbTCIUVH>;
	Sun, 9 Mar 2003 15:21:07 -0500
Date: Sun, 9 Mar 2003 21:31:44 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: struct inode size reduction.
Message-ID: <20030309203144.GA3814@win.tue.nl>
References: <20030309135402.GB32107@suse.de> <20030309171314.GA3783@win.tue.nl> <20030309203359.GA7276@suse.de> <20030309195555.A22226@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309195555.A22226@infradead.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 07:55:55PM +0000, Christoph Hellwig wrote:
> On Sun, Mar 09, 2003 at 07:33:59PM -0100, Dave Jones wrote:
> > There still seems to be some users of that, so I'll
> > leave that to a follow up patch, (or someone else who
> > really knows whats going on there).
> 
> No, there are no users yet.  But as people seem to be eager to make
> dev_t bigger we'll need when we tackle the "CIDR" thing for character
> devices, too.

No, I already wrote "CIDR" for character devices.
(Will submit it when 2.5.65 appears.)

There is no use for i_cdev or struct char_device today,
and I will not use it for character device registration.
So unless you or someone else decides to start using it,
it can just be thrown out.

Andries


[I already submitted the patch throwing it out, but someone,
maybe it was Roman Zippel, complained that that was going
in the wrong direction. In the very long run that may be true
(or not), but for 2.6 I do not see the point of this dead code.]

