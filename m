Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVACAra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVACAra (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 19:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVACAr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 19:47:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44045 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261374AbVACApx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 19:45:53 -0500
Date: Mon, 3 Jan 2005 01:45:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: William Lee Irwin III <wli@debian.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050103004551.GK4183@stusta.de>
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com> <20050103003011.GP29332@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103003011.GP29332@holomorphy.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 04:30:11PM -0800, William Lee Irwin III wrote:
> Adrian Bunk wrote:
> >> The main advantage with stable kernels in the good old days (tm) when 4 
> >> and 6 were even numbers was that you knew if something didn't work, and 
> >> upgrading to a new kernel inside this stable kernel series had a 
> >> relatively low risk of new breakages. This meant one big migration every 
> >> few years and relatively easy upgrades between stable series kernels.
> >> Nowadays in 2.6, every new 2.6 kernel has several regressions compared 
> >> to the previous one, and additionally obsolete but used code like 
> >> ipchains and devfs is scheduled for removal making upgrades even harder 
> >> for many users.
> 
> On Sun, Jan 02, 2005 at 05:49:08PM -0500, Bill Davidsen wrote:
> > And there you have my largest complaint with the new model. If 2.6 is 
> > stable, it should not have existing features removed just because 
> > someone has a new wet dream about a better but incompatible way to do 
> > things. I expect working programs to be deliberately broken in a 
> > development tree, but once existing features are removed there simply is 
> > no stable set of features.
> 
> The presumption is that these changes are frivolous. This is false.
> The removals of these features are motivated by their unsoundness,
> and those removals resolve real problems. If they did not do so, they
> would not pass peer review.

The netfilter people plan to remove ipfwadm and ipchains before 2.6.11 .

This is legacy code that makes their development sometimes a bit harder, 
but AFAIK ipchains in 2.6.10 doesn't suffer from any serious real 
problems.

> Adrian Bunk wrote:
> >> There's the point that most users should use distribution kernels, but 
> >> consider e.g. that there are poor souls with new hardware not supported 
> >> by the 3 years old 2.4.18 kernel in the stable part of your Debian 
> >> distribution.
> 
> On Sun, Jan 02, 2005 at 05:49:08PM -0500, Bill Davidsen wrote:
> > The stable and development kernel model worked for a decade, partly 
> > because people could build on a feature set and not have that feature 
> > just go away, leaving the choice of running without fixes or not 
> > running. Since we manage to support 2.2 and 2.4 (and perhaps even 2.0?) 
> > I don't see why the definition of "stable" can't simply mean "no 
> > deletions from the feature set" and let new features come in for those 
> > who want them. Absent that 2.4 will be the last stable kernel, in the 
> > sense that features won't be deliberately broken or removed.
> 
> I can't speak for anyone during the times of more ancient Linux history;
> however, developers' dissatisfaction with the development model has been
> aired numerous times in certain fora. It has not satisfactorily served
> developers or users. Users are locked into distro kernels for
> incompatible extensions, and developers are torn between multiple
> codebases.

At least on Debian, ftp.kernel.org kernels work fine.

> This fragmentation of programmer effort is trivially recognizable as
> counterproductive. A single focal point for programmer effort is far
> superior for a development model. If the standard of stability is not
> passed then the code is not ready to be included in any kernel. Then
> the distinction is lost, and each of the fragmented codebases gets a
> third-class effort, and a spurious expenditure of effort is wasted on
> porting fixes and features across numerous different codebases.
>...

My impression is that currently 2.4 doesn't take that much time of 
developers (except for Marcelo's), and that it's a quite usable and 
stable kernel.

> -- wli

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

