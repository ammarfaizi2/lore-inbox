Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265488AbUAZDsz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 22:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265493AbUAZDsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 22:48:55 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52958 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265488AbUAZDsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 22:48:53 -0500
Date: Mon, 26 Jan 2004 04:48:50 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, cova@ferrara.linux.it, eric@cisu.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040126034850.GC513@fs.tum.de>
References: <200401232253.08552.eric@cisu.net> <200401252221.01679.cova@ferrara.linux.it> <20040125214653.GB28576@colin2.muc.de> <200401252308.33005.cova@ferrara.linux.it> <20040125221304.GD28576@colin2.muc.de> <20040125142500.526dcac5.akpm@osdl.org> <20040125223105.GE28576@colin2.muc.de> <20040125145948.581d753c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125145948.581d753c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 02:59:48PM -0800, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> > On Sun, Jan 25, 2004 at 02:25:00PM -0800, Andrew Morton wrote:
> > > Andi Kleen <ak@muc.de> wrote:
> > > >
> > > > I would suspect the new weird CPU
> > > >  configuration stuff.
> > > 
> > > What do you believe is wrong with it?
> > 
> > It's different and it is weird and probably easy to screw up.
> > 
> 
> I must say that it does seem to be causing quite a few problems and doesn't
> have a very good benefit:breakage ratio.  Maybe we should say that 2.6 has
> sucky CPU selection and leave it for 2.7.  

The cpu selection patch is perhaps a bit prominent and therefore the
first suspect in case of problems. After looking at yesterday's problems
(including looking through the .config's) I'd claim that my cpu
selection changes are definitely not guilty. Besides that it broke
"allnoconfig" I haven't yet seen it having big problems caused.

Your impression might be different, and you are the one who makes the 
decisions.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

