Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315513AbSEMDGM>; Sun, 12 May 2002 23:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315514AbSEMDGL>; Sun, 12 May 2002 23:06:11 -0400
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:33732 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S315513AbSEMDGL>; Sun, 12 May 2002 23:06:11 -0400
Message-ID: <3CDF2C7C.7090203@linuxhq.com>
Date: Sun, 12 May 2002 23:01:16 -0400
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Unofficial but Supported Kernel Patches
In-Reply-To: <Pine.LNX.4.33L2.0205121935000.18593-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Mon, 13 May 2002, Tomas Szepe wrote:
> 
> | > [Randy.Dunlap <rddunlap@osdl.org>, May-12 2002, Sun, 16:32 -0700]
> | >
> | > What I would like is for someone to maintain a set of
> | > "required" patches to each new kernel --
> | > "required" here meaning "these patches are needed for kernel
> | > x.y.z to build or boot cleanly."
> | >
> | > The patchsets would contain only compile/link fixes and
> | > critical logic fixes to release and pre-release kernels.
> |
> | Do you mean something even more
> | "select fault_and_patch from kernel group by release;" than
> | http://www.codemonkey.org.uk/Linux-2.5.html
> | ?
> 
> That might be what I suggested, except that I can't find it
> there... That's a status/TODO list.
> 

Right now I maintain a kernel tree on linuxhq to which I apply all of 
the patches posted on the kernel mailing list (without filtering at 
all).  I don't think this was very useful, so I was thinking about 
simply providing a list of all maintained (but currently not applied) 
patches -- things like Rik van Riel's VM, and perhaps put up all of the 
patches being developed by Universities and other research institutions 
willing to share their stuff.

I didn't think providing patches needed to compile would be very useful, 
  because it seems that many people do this already (most notably, Alan 
Cox does this for Marcelo, and Dave Jones does this for Linus).

I inherited linuxhq.com and would like to make it into something more 
useful.  Since kernelnewbies does such a wonderful job catering to the 
newbies, I figured that linuxhq needed a new niche (and I needed 
something funner to do with my time).  So please let me know what types 
of things you kernel folk would like to see but have no time to do 
themselves, and I can accomodate.

Some ideas:

[1] Performance Measurements.  (Though I would need some help from the 
kernel community to identify which suites are the most useful to run the 
kernels against).

[2] Kernel Programming Documentation.  This would mostly document the 
kernel API, and important kernel data structures, as well as "good 
habits" in kernel development -- like "don't use virt_to_bus use 
blah,blah,blah".  Information like this might be useful to kernel 
janitors.  (This probably exists already).

[3] Necessary patches for each release.

I will do any and maybe all things that folks find useful...
other suggestions also welcome.

