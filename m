Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279240AbRJWFHz>; Tue, 23 Oct 2001 01:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279241AbRJWFHp>; Tue, 23 Oct 2001 01:07:45 -0400
Received: from virtucon.warpcore.org ([216.81.249.22]:62339 "EHLO virtucon")
	by vger.kernel.org with ESMTP id <S279240AbRJWFHa>;
	Tue, 23 Oct 2001 01:07:30 -0400
Date: Tue, 23 Oct 2001 00:08:26 -0500
From: drevil@warpcore.org
To: linux-kernel@vger.kernel.org
Cc: tegeran@home.com
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
Message-ID: <20011023000826.A22123@virtucon.warpcore.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, tegeran@home.com
In-Reply-To: <20011022172742.B445@virtucon.warpcore.org> <E15vnuN-0003jW-00@the-village.bc.nu> <20011022203159.A20411@virtucon.warpcore.org> <20011022214324.A18888@alcove.wittsend.com> <20011022211622.B20411@virtucon.warpcore.org> <003801c15b7d$6e2e4410$01c510ac@c779218a>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003801c15b7d$6e2e4410$01c510ac@c779218a>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 09:44:41PM -0700, Nicholas Knight wrote:
> look buddy, you don't get it
> without access to nvidia's source, we can't know what it does, where it does
> it, and what we can break by doing what to the kernel
> WE CAN NOT KNOW SO WE CAN NOT PREVENT IT
> it is THAT simple
> complain to nvidia, not the people that CAN NOT DO ANYTHING ABOUT IT

Thanks for the all caps, I love being deafened. However, I do "get it buddy."
Secondly, I don't believe for a second that it isn't possible to trace things
down even in a 'binary-only' driver. I trace things down in a 'binary-only'
program every day practically when dealing with software, many times having the
source to a program doesn't even help me. Often I find myself using strace or
some other program to trace the execution flow of a program because it is often
more informative then the poorly written source.

I'm not complaining about the NVidia driver here. I'm simply stating that IMHO,
I find it odd that for years microsoft has not only retained binary
compatability within a release of windows but API compatability. There should
not be a change to the kernel that would require changes in the driver in a
"stable development" release tree, it's really that simple in my perhaps
somewhat limited view. Admittedly, this breakage (which is still in doubt) that
might have happened did happen with a "pre" version, but I feel this response
would have been no different even if that was not the case.

And as I've mentioned before, I know of specific cases (which I'm not allowed to
divulge) where microsoft did not have access to the vendor's source to a
specific driver, but they collected information that was then forwarded on to
the vendor to handle the request. Nowhere during this entire 'discussion' did I
see an offer to help the user possibly collect that information in a manner that
would be helpful to the vendor, nor an offer of somewhat more information
than "go cry to your vendor, you poor sap" effectively. That is what, if
anything, I'm complaining about.

I deal with issues often day during the course of developing software for my
company that are often caused by other vendor's software, but does that mean I
can tell all my customers "I'm sorry, a change I made or a bug in your vendor's
software prevents this from functioning properly, and I can't help you at all."
My customers wouldn't accept that answer for a minute, they demand something
more than "sorry, it's not my fault." Often times we spend a good amount of time
researching and finding a way to work around the issues with that vendor's
product, which sometimes even involve "fixes" to our own product that exist for
no other reason than because of that vendor's issues. And guess what, we still
have customers :) And considering we're a somewhat small business in a dismal
economy I attribute part of our success to that very thing...

