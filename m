Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261841AbSJNDFi>; Sun, 13 Oct 2002 23:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbSJNDFi>; Sun, 13 Oct 2002 23:05:38 -0400
Received: from franka.aracnet.com ([216.99.193.44]:49848 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261841AbSJNDFh>; Sun, 13 Oct 2002 23:05:37 -0400
Date: Sun, 13 Oct 2002 20:09:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Greg KH <greg@kroah.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Summit support for 2.5 [0/4]
Message-ID: <1928331494.1034539762@[10.10.2.3]>
In-Reply-To: <20021014022515.GB1768@kroah.com>
References: <20021014022515.GB1768@kroah.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> PS. This distros want Summit to autodetect for their install kernels,
>> which is what the x86_summit switch is for.
> 
> Why?  Can't summit boot just fine on a i386 UP kernel?  Then they can
> look at the chipset id and determine that they should install a
> summit-built kernel, right?

Probably could, but that's what they asked for. Maybe they don't mean
install kernel, but just running kernel in general. I presume they
don't want to maintain a seperate kernel just for Summit.
 
> Can this just be CONFIG_SUMMIT?  I think most of these fixes need to be
> around for the ia64 version too :(

Nope, this is all under the i386 arch tree. ia64 can do what they
please, as far as I'm concerned.

> As we're going to end up with a mess of a ifdef nest over time with new
> archs added, how about something like this (completly untested):

Yeah, that was a quick hack by some idiot who doesn't speak much make ;-)
I'll steal Kai's thing from later in this thread.

> Other than that, looks like a good start to me (oh your email client is
> wrapping lines of the patch...)

Yeah, home email is borked for that, sorry. I'll do it properly when I
submit it.

M.

