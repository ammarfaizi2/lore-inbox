Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWJHGjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWJHGjt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 02:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWJHGjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 02:39:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63498 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750787AbWJHGjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 02:39:49 -0400
Date: Sun, 8 Oct 2006 08:39:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1: known regressions (v2)
Message-ID: <20061008063943.GB6755@stusta.de>
References: <EXSVLRB01xe0ymQ1WE900000265@exsvlrb01.hq.netapp.com> <20061008045522.GG29474@stusta.de> <1160283948.10192.3.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160283948.10192.3.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2006 at 01:05:48AM -0400, Trond Myklebust wrote:
> On Sun, 2006-10-08 at 06:55 +0200, Adrian Bunk wrote:
> > On Sat, Oct 07, 2006 at 09:43:51PM -0700, Trond Myklebust wrote:
> > > On Sat, 2006-10-07 at 23:46 +0200, Adrian Bunk wrote:
> > > 
> > > > Subject    : NFSv4 fails to mount (timeout)
> > > > References : http://bugzilla.kernel.org/show_bug.cgi?id=7274
> > > > Submitter  : Torsten Kaiser <kernel@bardioc.dyndns.org>
> > > > Guilty     : Trond Myklebust <Trond.Myklebust@netapp.com>
> > > >              commit 51b6ded4d9a94a61035deba1d8f51a54e3a3dd86
> > > > Handled-By : Trond Myklebust <Trond.Myklebust@netapp.com>
> > > > Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=7274
> > > > Status     : patch available
> > > 
> > > Thanks... Always nice to hear that you have been judged and found
> > > guilty. Now go and reread that fucking bug report...
> > 
> > As far as I understand it it is the sum of two bugs, and one of them 
> > is the one from commit 51b6ded4d9a94a61035deba1d8f51a54e3a3dd86.
> 
> That really comes across in the above message. I read it and immediately
> thought "that must be two bugs".

It contains one kernel bug plus a non-kernel bug.

Many people (including myself) are often "guilty" of introducing a 
kernel bug - that's simply normal.

> In any case, what the fuck gives you the right to appoint yourself judge
> and jury over kernel regressions?

I've given this right myself - everyone can always send any bug list he
wants to linux-kernel.

I already did the same during 2.6.15 development.

Besides being a nice way to show people that the "noone tests -rc kernels"
theory is wrong, it also points people at the known regressions and 
might result in more of them being fixed.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

