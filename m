Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266085AbRF1S2Z>; Thu, 28 Jun 2001 14:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266086AbRF1S2P>; Thu, 28 Jun 2001 14:28:15 -0400
Received: from mean.netppl.fi ([195.242.208.16]:17420 "EHLO mean.netppl.fi")
	by vger.kernel.org with ESMTP id <S266085AbRF1S2H>;
	Thu, 28 Jun 2001 14:28:07 -0400
Date: Thu, 28 Jun 2001 21:28:05 +0300
From: Pekka Pietikainen <pp@evil.netppl.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
Message-ID: <20010628212805.A19547@netppl.fi>
In-Reply-To: <Pine.LNX.4.33.0106280956030.15199-100000@penguin.transmeta.com> <6082.993748704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <6082.993748704@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2001 at 06:18:24PM +0100, David Woodhouse wrote:
> 
> 
> torvalds@transmeta.com said:
> > Things like version strings etc sound useful, but the fact is that the
> > only _real_ problem it has ever solved for anybody is when somebody
> > thinks they install a new kernel, and forgets to run "lilo" or
> > something.
> 
> I can give counter-examples of times when it's been extremely useful to 
> know exactly what version the user is running, and the info messages
> included in their first bug report have told me exactly what I needed to 
> know.
> 
> Only for code which is always distributed as part of the kernel, and where 
> there are never any more up to date versions in the maintainer's tree, even 
> temporarily.
Indeed, and even if you're talking about kernel x.y.z the
user might in fact be running a vendor-patched kernel with a newer
version of the driver (and the author would still have to find out
what version of the driver was included).

For other things the version string is pretty useless as it isn't ever
updated (e.g. networking), and there the kernel version is enough
information.

What I'd propose is a recommendation that modules in 
addition to the "useful" information a module should print
a maximum of one line (80 chars), and the author gets to
choose what they want in there, version information, driver homepage,
copyright, sponsor, whatever.

I just hope we never get to the point of having a "Memory leak removal
sponsored by Tampax" boot message ;)

-- 
Pekka Pietikainen
