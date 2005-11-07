Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbVKGS2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbVKGS2M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbVKGS2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:28:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:39049 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964903AbVKGS2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:28:12 -0500
Date: Mon, 7 Nov 2005 10:24:34 -0800
From: Greg KH <greg@kroah.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: udev on 2.6.14 fails to create /dev/input/event2 on T40 Thinkpad
Message-ID: <20051107182434.GC18861@kroah.com>
References: <E1EYdMs-0001hI-3F@think.thunk.org> <20051106203421.GB2527@kroah.com> <20051107053648.GA7521@thunk.org> <20051107155243.GA14658@kroah.com> <20051107181706.GB8374@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107181706.GB8374@thunk.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 01:17:06PM -0500, Theodore Ts'o wrote:
> On Mon, Nov 07, 2005 at 07:52:43AM -0800, Greg KH wrote:
> > > Yes, sorry, I got confused about which tree I had booting; this was
> > > indeed a post-2.6.14 kernel (pulled using hg).
> > 
> > Ah good, scared me for a bit there :)
> > 
> > > Documentation/changes at the tip as of tonight still says use "udev
> > > version 071", which is what I have installed.
> > 
> > Which should handle this just fine.  I suggest you file a bug against
> > the debian package if this is not the case.
> 
> Ok, I'll gather more information but I was indeed using udev 0.71

Minor nit, udev does not use "." in its version numbers :)

> from Debian with a post 2.6.14 kernel, and it wasn't working for me.

I see that 073 is in unstable, which fixed a lot of problems with 071,
072 and 073 due to Debian configuration issues.  I suggest you try that.

> I can try again with stock udev from kernel.org,

No, stick with the debian packages, due to the wierd packaging and init
issues that Debian has.

I wouldn't recommend using the kernel.org udev packages for anyone on
their own these days, they are what the distros use to package from, and
they know best, due to the different ways the init process works in
different distros.

Good luck,

greg k-h
