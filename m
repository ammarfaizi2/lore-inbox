Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbVLFHGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbVLFHGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 02:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbVLFHGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 02:06:41 -0500
Received: from ns.suse.de ([195.135.220.2]:30901 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751400AbVLFHGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 02:06:41 -0500
From: Neil Brown <neilb@suse.de>
To: Willy Tarreau <willy@w.ods.org>
Date: Tue, 6 Dec 2005 18:06:07 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17301.14431.887295.711118@cse.unsw.edu.au>
Cc: Greg KH <greg@kroah.com>, Tim Bird <tim.bird@am.sony.com>,
       Dave Airlie <airlied@gmail.com>, David Woodhouse <dwmw2@infradead.org>,
       arjan@infradead.org, andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
In-Reply-To: message from Willy Tarreau on Tuesday December 6
References: <21d7e9970512051610n1244467am12adc8373c1a4473@mail.gmail.com>
	<4394DA1D.3090007@am.sony.com>
	<20051206040820.GB26602@kroah.com>
	<20051206060734.GB7096@alpha.home.local>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday December 6, willy@w.ods.org wrote:
> On Mon, Dec 05, 2005 at 08:08:20PM -0800, Greg KH wrote:
>  
> > For people to think that the kernel developers are just "too dumb" to
> > make a stable kernel api (and yes, I've had people accuse me of this
> > many times to my face[1]) shows a total lack of understanding as to
> > _why_ we change the in-kernel api all the time.  Please see
> > Documentation/stable_api_nonsense.txt for details on this.
> 
> It's not about being dumb, but this problem is -I think- what prevents
> some companies from releasing drivers for their hardware (when they
> don't consider that opening it will give their IP away). I've played
> several times with opensource drivers for ADSL modems, LCD modules,
> watchdogs, ethernet adapters, IDE drivers, etc... and their problem
> was that what worked well in 2.4.21 did not even build in 2.4.22
> and became difficult to fix starting with 2.4.23. Most of those
> small companies who propose a Linux driver simply start by paying
> a student during summer for porting their windows/sco/whatever
> driver to linux. They think the job is done when he leaves.
> Unfortunately, they receive complaints 3 months later from users
> because the driver is broken and does not build. They don't have
> the resources to keep a permanent developer on it, and they
> quickly understand that Linux is just a "geek OS" and that it's
> the last time they release any driver.
> 
> Of course, you'll tell me that they can write the driver for
> the major stable distros (RHEL, SLES, ...). 

I won't tell you that.
I'd say that with a linux driver, the job isn't done it "works", but
rather the job is done when it "is merged".

Once it is merged, it will mostly be updated along with the rest of
the kernel, and if it breaks silently, there is probably someone
available who can fix it.

I think we should frown on out-of-tree drivers nearly as much as
closed-source drivers.

NeilBrown
