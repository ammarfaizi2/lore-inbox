Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279265AbRJWF7O>; Tue, 23 Oct 2001 01:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279266AbRJWF7F>; Tue, 23 Oct 2001 01:59:05 -0400
Received: from femail41.sdc1.sfba.home.com ([24.254.60.35]:56278 "EHLO
	femail41.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S279265AbRJWF6z>; Tue, 23 Oct 2001 01:58:55 -0400
Message-ID: <007301c15b87$dcaf67c0$01c510ac@c779218a>
From: "Nicholas Knight" <tegeran@home.com>
To: <drevil@warpcore.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20011022172742.B445@virtucon.warpcore.org> <E15vnuN-0003jW-00@the-village.bc.nu> <20011022203159.A20411@virtucon.warpcore.org> <20011022214324.A18888@alcove.wittsend.com> <20011022211622.B20411@virtucon.warpcore.org> <003801c15b7d$6e2e4410$01c510ac@c779218a> <20011023000826.A22123@virtucon.warpcore.org>
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
Date: Mon, 22 Oct 2001 22:59:22 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: <drevil@warpcore.org>
To: <linux-kernel@vger.kernel.org>
Cc: <tegeran@home.com>
Sent: Monday, October 22, 2001 10:08 PM
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module


> On Mon, Oct 22, 2001 at 09:44:41PM -0700, Nicholas Knight wrote:
> > look buddy, you don't get it
> > without access to nvidia's source, we can't know what it does, where it
does
> > it, and what we can break by doing what to the kernel
> > WE CAN NOT KNOW SO WE CAN NOT PREVENT IT
> > it is THAT simple
> > complain to nvidia, not the people that CAN NOT DO ANYTHING ABOUT IT
>
> Thanks for the all caps, I love being deafened. However, I do "get it
buddy."
> Secondly, I don't believe for a second that it isn't possible to trace
things
> down even in a 'binary-only' driver. I trace things down in a
'binary-only'
> program every day practically when dealing with software, many times
having the
> source to a program doesn't even help me. Often I find myself using strace
or
> some other program to trace the execution flow of a program because it is
often
> more informative then the poorly written source.
>
> I'm not complaining about the NVidia driver here. I'm simply stating that
IMHO,
> I find it odd that for years microsoft has not only retained binary
> compatability within a release of windows but API compatability. There
should

Only within a single kernel.
How many releases of windows have a kernel upgrade avalible? *POSSIBLY*
occasional changes to the kernel bewteen NT service packs, and those service
packs have a tendancy to break third party drivers.

There are at least 2, possibly 3 releases of Win95, there are a number of
drivers that work with one but not another.

Win98 and Win98SE seem for the most part to retain compatability, but then,
I doubt there was anything much changed in the kernel (but then we wouldn't
know that for sure since we don't have the source).

Here, we're dealing with changes to the core of the operating system, if you
don't like it, do as another person suggested, install one version and stick
with it, don't upgrade until you're ready to deal with old drivers not
working with new versions. Consider each release of the kernel to be
equivilant to a new release of windows as far as binary-only drivers go,
same old programs will *probably* run, but drivers can go out the window.

> not be a change to the kernel that would require changes in the driver in
a
> "stable development" release tree, it's really that simple in my perhaps

What if it was a bug fix that caused the driver to break? What if it was a
fix to 3 other drivers? We won't really know for sure since we don't have
the source, nor can we prevent further breakage in the future for the same
reason.

> somewhat limited view. Admittedly, this breakage (which is still in doubt)
that
> might have happened did happen with a "pre" version, but I feel this
response
> would have been no different even if that was not the case.

Would you have run mid-development 2.3 kernels in a production environment
that you weren't prepared to have things break in? Then why are you running
a -pre version and complaining that it's "linux's fault" that a third-party
binary-only driver that does things we may not know about breaks? nVidia
will likely have a fix out around the time or before 2.4.13 is released as
final, which is as it should be, nVidia owns the code and maintains it,
they're the ones that make it work with a new version, not the people that
don't have access to the code.

>
> And as I've mentioned before, I know of specific cases (which I'm not
allowed to
> divulge) where microsoft did not have access to the vendor's source to a
> specific driver, but they collected information that was then forwarded on
to
> the vendor to handle the request. Nowhere during this entire 'discussion'
did I
> see an offer to help the user possibly collect that information in a
manner that
> would be helpful to the vendor, nor an offer of somewhat more information
> than "go cry to your vendor, you poor sap" effectively. That is what, if
> anything, I'm complaining about.

Does anyone here have reliable contacts with nVidia that'll actually get
something done in a reasonable time? Faster than if nVidia just tested the
new kernels as they likely do quite often and found the problem themselves
and had all possible information avalible immiediately? Hmm...

>
> I deal with issues often day during the course of developing software for
my
> company that are often caused by other vendor's software, but does that
mean I
> can tell all my customers "I'm sorry, a change I made or a bug in your
vendor's
> software prevents this from functioning properly, and I can't help you at
all."
> My customers wouldn't accept that answer for a minute, they demand
something

*Customers* ? What customers? Where exactly is this guy paying anyone here
for support or to maintain the code?

> more than "sorry, it's not my fault." Often times we spend a good amount
of time
> researching and finding a way to work around the issues with that vendor's
> product, which sometimes even involve "fixes" to our own product that
exist for

Kernel developers spend a significant amount of time trying to work around
problems in third party products, or did you not notice the PCI quirks, and
other workarounds present in the kernel? Did you not notice the EXTENSIVE
discussions on the VIA KT133A problems? The extensive time spent trying to
track down what was going on? I spent probably 4 to 6 hours over the course
of a few days just collecting and looking at information, multiply that for
all the people who sent me reports for the time they spent trying to figure
out what the problem was, recompiling kernels, messing with hardware, trying
alternate CPU's, etc. etc. etc. comes out to about 240 to 360 man hours, 10
to 15 man days. This doesn't include the time several developers spent
trying new code, and all the people before my initial requests who spent
extensive time debugging and trying new code.
And, in that case, we had access to all the source for the code involved,
plus several applicable technical documents.

Now you're asking developers to debug a third-party driver that the source
is not avalible for, that we don't know exactly what it accesses, what it
does, what information it sends to the hardware, what information it gets
from the kernel, etc.
Could it be a one-liner and take 20 minutes to track down with one
developer? maybe, but then again, could be a hell of a lot more trouble, and
this is to fix a third-party driver that in the opinion of many people
shouldn't even be allowed to touch the kernel, much less make it the
responsability of Linux developers to deal with its problems.

> no other reason than because of that vendor's issues. And guess what, we
still
> have customers :) And considering we're a somewhat small business in a
dismal
> economy I attribute part of our success to that very thing...

Guess what? We don't have customers, never did. Companies like Red Hat have
customers, and those companies even employ some kernel developers, if they
want to have their employees work on the problem, fine, that's their
perogative, and I'm sure there would be people that are quite grateful, and
might even buy their product because of it. but in general, linux kernel
developers won't be able to, nor will they try to, fix a problem with a
binary-only driver.

