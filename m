Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275527AbRJAUxT>; Mon, 1 Oct 2001 16:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275539AbRJAUxJ>; Mon, 1 Oct 2001 16:53:09 -0400
Received: from [194.213.32.141] ([194.213.32.141]:2308 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S275527AbRJAUw7>;
	Mon, 1 Oct 2001 16:52:59 -0400
Message-ID: <20010930220523.B186@bug.ucw.cz>
Date: Sun, 30 Sep 2001 22:05:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: prettygood@cs.stanford.edu, linux-kernel@vger.kernel.org
Subject: Re: Cramfs Endianness
In-Reply-To: <Pine.LNX.4.33.0109261640310.19715-100000@earth.ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.33.0109261640310.19715-100000@earth.ayrnetworks.com>; from Brad on Wed, Sep 26, 2001 at 04:55:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Although the documentation states that always going with little endian is
> the easiest solution and what was "decided" on, neither the kernel nor
> mkcramfs swabs on a big endian machine.  This is decidedly a problem with
> what we're doing, so I wrote a patch to swab the easy and not-quite-so-easy
> bitfields such that mkcramfs writes little endian images and the kernel
> swabs (if byteorder is defined as big_endian or __MIPSEB__ is defined)..
> It looks at the magic to determine whether to swab or not.
> 
> We've needed this, so we will have to incorporate this into a parallel
> repository if not added to the kernel.  Is there another solution afoot,
> or might I submit this patch? (please cc me if you respond)

Just submit the patch.

								Pavel
				...whose mips box is fortunately
					little endian...

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
