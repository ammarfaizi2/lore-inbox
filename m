Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263238AbUCNA5r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 19:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263236AbUCNA5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 19:57:47 -0500
Received: from waste.org ([209.173.204.2]:64198 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263238AbUCNA5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 19:57:39 -0500
Date: Sat, 13 Mar 2004 18:57:26 -0600
From: Matt Mackall <mpm@selenic.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Bloat report 2.6.3 -> 2.6.4
Message-ID: <20040314005726.GS20174@waste.org>
References: <20040312204458.GJ20174@waste.org> <20040312152206.61604447.akpm@osdl.org> <20040312235349.GK20174@waste.org> <20040313170839.GV14833@fs.tum.de> <20040313173331.GO20174@waste.org> <20040313175712.GY14833@fs.tum.de> <20040313235940.GQ20174@waste.org> <20040314003220.GG14833@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314003220.GG14833@fs.tum.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 01:32:20AM +0100, Adrian Bunk wrote:
> On Sat, Mar 13, 2004 at 05:59:40PM -0600, Matt Mackall wrote:
> > On Sat, Mar 13, 2004 at 06:57:13PM +0100, Adrian Bunk wrote:
> >...
> > > > But I think it's fair to say that new features that are on by default
> > > > are in fact bloat in some sense.
> > > 
> > > Perhaps in some sense, but not in any interesting sense.
> > > 
> > > For the average computer you can buy at your supermarket today it isn't 
> > > very interesting whether the kernel is bigger by 1 MB or not.
> > >
> > > People who need to care about the size of the kernel [1] use hand-tuned 
> > > .config's that are far away from defconfig - and those people wouldn't 
> > > enable unneeded features that are on by default.
> > 
> > And my coverage of creep in other _commonly used_ parts of the kernel
> > would then be nil. Given that allyesconfig can't be expected to build
> > a kernel on any given day, defconfig is the least arbitrary and most
> > useful of arbitrary choices.
> > 
> > > You use a metric "size increase of a defconfig kernel [2]", and I simply 
> > > claim that this metric doesn't measure anything useful for practical 
> > > purposes.
> > 
> > defconfig is not an unreasonable approximation of features people use. 
> 
> What exactly is your goal?
> 
> As already said:
>   *** For the average user, the size of the kernel doesn't matter *** [1]
>   *** People that care about size don't use defconfig ***

Neither of these things matter. The important thing is that defconfig
encompasses a range of common options that are likely to be used, thus
people care about growth in those areas regardless of what subset or
superset they actually use. It is not possible to see growth in the
code for option FOO if option FOO is not enabled. As I pointed out in
the last message, allyesconfig would be ideal for my purposes and
fails both of the above quite dramatically.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
