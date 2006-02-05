Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWBEPNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWBEPNQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 10:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWBEPNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 10:13:16 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60684 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750870AbWBEPNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 10:13:15 -0500
Date: Sun, 5 Feb 2006 16:13:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marc Koschewski <marc@osknowledge.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, dtor_core@ameritech.net,
       rlrevell@joe-job.com, 76306.1226@compuserve.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Wanted: hotfixes for -mm kernels
Message-ID: <20060205151314.GD5271@stusta.de>
References: <200602021502_MC3-1-B772-547@compuserve.com> <1138913633.15691.109.camel@mindpipe> <d120d5000602021345i255bb69eydb67bc1b0a448f8d@mail.gmail.com> <20060203100703.GA5691@stiffy.osknowledge.org> <20060204083752.a5c5b058.mbligh@mbligh.org> <20060204185738.GA5689@stiffy.osknowledge.org> <20060204204139.GA4528@stusta.de> <20060205090959.GC5663@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060205090959.GC5663@stiffy.osknowledge.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2006 at 10:09:59AM +0100, Marc Koschewski wrote:
> * Adrian Bunk <bunk@stusta.de> [2006-02-04 21:41:39 +0100]:
> > On Sat, Feb 04, 2006 at 07:57:39PM +0100, Marc Koschewski wrote:
>...
> > > We talked about hotfixes for -mm. So why not check these into the -mm-git tree
> > > then? This would make sense and would conform fully to my understanding of what
> > > the -mm-git tree should be. I don't want to select 23 patches from LKML to make
> > > the tree compile or work. I want to checkout. Why make it easy when you may get
> > > it difficult.
> > >...
> > > What sense does an -mm tree make when there are people that cannot test it because of
> > > known bugs that lead to the -mm tree not being bootable or - even worse - destroying
> > > the system?
> > 
> > That's exactly what Andrew does now implement through the hot-fixes
> > directory [1].
>...
> Moreover, just _one_ more thing which is most important at least to me:
> If one can do a checkout on a daily basis with let's say 3 new patches checked
> in, one can test these. The other day there are maybe another 2 new patches
> applied which are to be tested. This would just speed up the testing cycle
> whereas a 3 MB patch with tons of fixes and testing is just like a kick-down
> with the hand-brake pulled. Sometimes I#M really overwhelmed by how many patches
> came in with the recent -mm. ACPI, ALSA, VM, various FS stuff, ... It's quite
> impossible to me to really test the patches in an effective manner due to having
> my 2 eyes focussed on too many things at one. I do test ALSA with various types
> of in/out operation while my reiserfs partition is on the way to hell. To me
> that doesn't sound like effective testing.
> 
> This is just about testing and debugging time effectiveness and not about some
> religious thing a la SCM vs. patches.

Hotfixes are something that can be done.

What you suggest is not really possible.

Your thinko is:
3 new patches a day don't sum up to 3 MB after one week.

As far as I understand it, the big work for Andrew is integrating two 
dozen git repositories and at about thousand patches in a way that:
- everything applies
- the kernel compiles on several architectures
- the kernel actually runs on some machines

Andrew does all this before he releases an -mm kernel (I know due to the 
feedback he sometimes gives for patches I sent), and this is the sole 
reason why most -mm kernels are half-way usable.

Some random snapshot from Andrew's repository wouldn't help anyone, 
either it's good enough that he releases an -mm kernel or it isn't worth 
other people testing it.

> Marc

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

