Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267722AbTACXtQ>; Fri, 3 Jan 2003 18:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267723AbTACXtP>; Fri, 3 Jan 2003 18:49:15 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:40132 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S267722AbTACXtM>; Fri, 3 Jan 2003 18:49:12 -0500
Date: Sat, 04 Jan 2003 12:56:53 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Andre Hedrick <andre@linux-ide.org>, Richard Stallman <rms@gnu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Gauntlet Set NOW!
Message-ID: <15900000.1041638213@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.10.10301031425590.421-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10301031425590.421-100000@master.linux-ide.org>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hear hear!

RMS, I've heckled you in person on this subject, so now I'm going to do it 
online too.

One aspect of freedom you carefully ignore is that of the writers of code 
to do what they will with it.  Now, in general I and my company do place 
our code under whichever free license makes sense for the particular 
project, as a matter of principle.  So we have produced code under GPL 
(linux kernel and emacs variants), BSD licenses (network protocols, BSD 
kernel, python libraries), patches to both python and perl under their own 
licenses, and even MPL code with the 'original developer' rights 
deliberately given to another company to maintain and distribute.  We are 
not hostile to free software, but neither are we to the right of original 
authors to make their own decisions.

But sometimes we can't make things free, either because it comes to close 
to core IP which we are legally bound to protect, or because it's a derived 
work of something we bought and don't ourselves have the right to 
redistribute.  Often this is hardware support code, sometimes it compiles 
into hardware (embedded FPGAs).  Even so, if we can we make it open-source, 
closed-distribution (in other words, to get the code you must have bought 
the license to the original IP).  This preserves as much freedom as we 
ourselves have been given the option to.

Linus has made it quite clear in the past that his position on binary 
modules is that they are explicitly allowed, but that the maintainers of 
such a thing 'get everything they deserve' in terms of maintenance hassle. 
Which is fair enough, the developers of the GPL kernel don't need the 
hassle of maintaining APIs to the degree that would guarantee backwards 
compatibility for pure binary modules.  To keep the kernel as good as it is 
and continue improving it, that is necessary.

To explicitly allow binary modules implies that the module loading process 
is not linking in the terms of the GPL.  The *only* grey area is the status 
of inline functions and assembler in the hearder files, and clever 
construction of a module's shim driver can deal with that one.

Andre, what I see you doing here is exactly what NVIDIA already did, which 
is (L)GPL the interface to the kernel and keep the core algorithms 
proprietary.  I don't know what your constraints are, but it doesn't 
matter, you are entitled to do that.  Even if it is simply that you want to 
make money off the code.  I take it that it's an iSCSI target for the Linux 
VFS or block device layer?  That would be very cool, and certainly worth 
basing a company on.

I understand from a former NVIDIA employee that NVIDIA are not able to GPL 
the whole driver since some of it is not their code; I suspect that some of 
the non-NVIDIA code actually belongs to Microsoft.  So they have opened it 
up to the extent possible for them.

Nowhere in any of this do I see anyone doing anything that is actually 
wrong.  By sueing either Andre or NVIDIA, Richard, you'd be the one 
committing the wrong, by taking away either Andre's freedom to decide on 
his business plans, or the communities access to NVIDIAs hardware, which 
they have provided with considerable goodwill.  And both Andre's goodwill 
and NVIDIAs are of considerable value to the community.

Neither of these are good test cases for the spirit of the GPL; the past 
events of, for instance, vendors refusing to release source for betas of a 
Linux distribution, are far more to the point.

And a test case based on kernel binary modules would be very destructive to 
the free software community.  First because it is likely to cause a mass 
exodus of vendors from Linux.  Where would they go?  BSD, of course, where 
no such issue can arise, as well as a variety of purely proprietary 
systems.  But more importantly, it would reinforce the whole concept of 
intellectual property in a manner that, in the end, will result in an even 
more hostile to freedom environment.  I think it is important for the free 
software community to remember that the freedom of all creators of ideas is 
vitally important, and for us not to contribute to the shackles being 
placed on music, literature, and science.  For ultimately, they are more 
important than software alone.

Andrew

--On Friday, January 03, 2003 15:01:51 -0800 Andre Hedrick 
<andre@linux-ide.org> wrote:

>
> Richard,
>
> I am going to sell and ship binary only models which is solely a protocol.
> One which is in a working group and is not an offical document but will be
> ratified soon.
>
> I will not release the source code period.  It is not a derived work.
> It can and will be capable of running it on other unixs as well has have a
> version for microsoft and maybe apple.
>
> The API and boundary will execute all kernel operations and calls outside
> of the core protocol.  There is no hardware period.  It is pure software.
> I am prepared to show the the source of the API callers; however, given
> the anal nature of the review I expect.  I need a few more days to extract
> every damn possible kernel function or caller that is even close to my
> property.  The object generated from that file will then be linked with a
> private closed source library, which may or may not be setup under LGPL.
>
> This would be the Library GPL and not the updated Lesser GPL.
> But I am not prepared to set this position yet.
>
> Are you prepared to SUE me ?
> Are you prepared to SUE others like me ?
> Are you prepared to SUE every company in Silicon Valley for embedded ?
> Are you prepared to SUE every settop box vendor ?
>
> Either, put up or walk on this issue.
>
> Fear, Threats, and Intimidation resulting from a willful grey zone so
> clearly and cleverly designed by yourself is not acceptable.
>
> Since I am in a position of loosing revenue today because of this silly
> issue of usage of headers and not any inline code inside them, I will seek
> counter damages if I am forced into litigation.
>
> Regards,
>
> Andre Hedrick
> LAD Storage Consulting Group
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


