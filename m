Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315785AbSFUKXz>; Fri, 21 Jun 2002 06:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSFUKXy>; Fri, 21 Jun 2002 06:23:54 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:15322 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S315785AbSFUKXy>; Fri, 21 Jun 2002 06:23:54 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jakob Oestergaard <jakob@unthought.net>
Date: Fri, 21 Jun 2002 20:24:29 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15634.65245.599087.397914@notabene.cse.unsw.edu.au>
Cc: William Thompson <wt@electro-mechanical.com>, linux-kernel@vger.kernel.org
Subject: Re: partition md raid?
In-Reply-To: message from Jakob Oestergaard on Friday June 21
References: <20020619103611.A7291@coredump.electro-mechanical.com>
	<15634.38076.959047.462763@notabene.cse.unsw.edu.au>
	<20020621073657.GC19794@unthought.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday June 21, jakob@unthought.net wrote:
> On Fri, Jun 21, 2002 at 12:51:40PM +1000, Neil Brown wrote:
> > On Wednesday June 19, wt@electro-mechanical.com wrote:
> > > Is this possible (w/o using lvm)
> > 
> > Yes, but you need a patch...
> ...
> 
> Any plans for getting this into the kernel Neil ?

I've been hanging out for 2.4.19 to be released.  Then I hope to
submit some of the changes that recently went into 2.5 (which sort out
the locking) and then the partitioning.

I suspect the functionality will end up in 2.5 one day, but I'm not
sure how and I'm not going to push it until (unless) the block_dev
layer settles down.

NeilBrown
