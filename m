Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129892AbQKHDvI>; Tue, 7 Nov 2000 22:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130779AbQKHDu7>; Tue, 7 Nov 2000 22:50:59 -0500
Received: from tantalum.btinternet.com ([194.73.73.80]:65161 "EHLO
	tantalum.btinternet.com") by vger.kernel.org with ESMTP
	id <S129892AbQKHDum>; Tue, 7 Nov 2000 22:50:42 -0500
From: davej@suse.de
Date: Wed, 8 Nov 2000 03:50:13 +0000 (GMT)
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <20001107213642.A8542@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0011080344080.8632-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Jeff V. Merkey wrote:

> What makes more sense is to pack multiple segments for different 
> processor architecures into a single executable package, and have the 
> loader pick the right one (the NT model).  It could be used for 
> SMP and non-SMP images, though, as well as i386, i586, i686, etc.  

Jeff, in x86 alone, there are 13 different compile targets (2.4 tree),
soon to be more when Cyrix III & Pentium IV get added.
Although it doesn't make sense on all of these, it's possible to
compile any of them with SMP support too.

That's 30 different combinations.
Suggesting to put all these into one file isn't a bad idea,
it's bordering on insanity. What do you hope to achieve by doing
this, apart from the end user not having to choose a custom kernel
for their architecture ? Much better to have several kernels built
seperately for each arch, and have the user pick which one
(or even have the distro installer autodetect) at install time,
as SuSE, Red Hat, Mandrake, and several other distros are now doing.

Everything all in one may be the way NT does it, but that does not
mean it's a good idea. In fact it's anything but a good idea.
Please don't try to bring the braindamages of NT to Linux, it
just isn't meant to happen.

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
