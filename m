Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279201AbRJWCPn>; Mon, 22 Oct 2001 22:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279204AbRJWCPd>; Mon, 22 Oct 2001 22:15:33 -0400
Received: from virtucon.warpcore.org ([216.81.249.22]:23427 "EHLO virtucon")
	by vger.kernel.org with ESMTP id <S279203AbRJWCPU>;
	Mon, 22 Oct 2001 22:15:20 -0400
Date: Mon, 22 Oct 2001 21:16:22 -0500
From: drevil@warpcore.org
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
Message-ID: <20011022211622.B20411@virtucon.warpcore.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011022172742.B445@virtucon.warpcore.org> <E15vnuN-0003jW-00@the-village.bc.nu> <20011022203159.A20411@virtucon.warpcore.org> <20011022214324.A18888@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011022214324.A18888@alcove.wittsend.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 09:43:24PM -0400, Michael H. Warfield wrote:
> 	Really?  Sure as hell hasn't been my experience.  Oh!  That only
> works with Windows 95!  Ok, now you can get the driver to support Windows
> 98 but it won't support Windows NT (got one RIGHT NOW like that).  Oops,
> you upgraded to Windows 2000, can't support that with that driver, we
> don't have a driver for that yet.  Windows XP, sorry, we don't have the
> Windows XP certified driver, yet, try back in a few months.

> 	Think that's a joke?  I think it's pathetic and it is EXACTLY
> what I have experienced with multimedia cards, scanners, and printers.

> 	Why would Windows XP break all the non-MS Windows 2000 drivers
> (don't you dare tell me it didn't, I work at a place that got slammed by
> their shit).  Why would things that work on Windows 98 (Delorme Eartha
> DVD) not work on Windows NT or Windows 2000.  The Windows mess is a swamp
> out there of what drivers work with what version (some don't even work
> between the original editions and updated editions - Windows 95 had
> three editions that I have in hand).

Hmm...where did I say once that the user upgraded their version of windows?
Note, I said windows 'update', not windows 'upgrade'. Theoretically, based off
the whole "odd", "even", "stable", "unstable" numbering system that was given,
Kernel 2.4.x should be one 'version', and should not randomly break
programs/drivers during it's 'completely bugfix' development? I wonder how much
more driver support we might see under Linux if it didn't break compatability
with existing drivers so much...

It could be said that at least windows has a somewhat "stable" (in the sense
that it doesn't change very often) driver API, something that Linux apparently
lacks currently. Stability comes from a lack of feature creep, and that's
something that Linux doesn't have currently.

It seems as if a user is forced to upgrade to a newer minor 'kernel revision'
often to gain hardware support even though other things may break because
interfaces may have changed. Compare this to windows, where the "Windows 98"
driver API changed very little (AFAIK) and it was pretty much guranteed that no
matter how many times a user "updated" his copy of Windows 98 (note that I did
not say NT) with service packs and or other fixes to his system his drivers
would still work, and where a user can often obtain updated device support
simply by upgrading his drivers instead of upgrading his core operating system.
Contrast this with Linux where the 'helter skelter, we can break stuff because
we know better' attitude, and you begin to see why so many companies might not
be intereseted in supporting Linux at all.

It seems as if the very model of the kernel precludes a vendor's ability to
produce a driver and have it work with almost the entire series of a particular
kernel 'release', such as 2.4, contrast this with windows where often a specific
driver may work for the entire period of that particular release...

I am advocating Windows? Hardly. What I am advocating is a little bit more
sanity. The OS should not break compatability with existing drivers so often for
a 'stable' release. I know that i'm not the only one here that is quite tired of
upgrading to newer versions of the kernel to fix some bugs, only to receive a
plethora of mind boggling hardware crashing others and to find that suddenly
their drivers don't work correctly any more. We've seen arguments over the
'stable' release series regarding the VM code, I won't even go there, but I
think it proves that I'm not the only one that finds "2.4.x's" tendency to break
things and pay for them later more than annoying...

Now of course, there is nothing here to say that the kernel has in any way
broken support with the NVidia driver, obviously this discussion is far beyond
that point, and it is rather irrelevant. I believe my above discussion is the
real root of the matter, and the NVidia driver is only an example of the real
issue. It's very possible that something else broke the driver for this user and
without the proper test data reported by the user (which was admittedly rather
sparse to begin with) very little debugging can be done and very little help can
be given...

This of course comes from my somewhat limited experience in the software
development business market, and as always YMMV...
