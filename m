Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWAUVZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWAUVZr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWAUVZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:25:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1920 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932359AbWAUVZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:25:45 -0500
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, bunk@stusta.de,
       linux-kernel@vger.kernel.org, pbadari@us.ibm.com,
       kenneth.w.chen@intel.com
In-Reply-To: <20060121131718.1b6bbcdc.akpm@osdl.org>
References: <20060119030251.GG19398@stusta.de>
	 <20060118194103.5c569040.akpm@osdl.org>
	 <1137833547.2978.7.camel@laptopd505.fenrus.org>
	 <20060121194102.GB28051@redhat.com> <20060121131718.1b6bbcdc.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 22:25:39 +0100
Message-Id: <1137878739.23974.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-21 at 13:17 -0800, Andrew Morton wrote:
> Dave Jones <davej@redhat.com> wrote:
> >
> > On Sat, Jan 21, 2006 at 09:52:27AM +0100, Arjan van de Ven wrote:
> >  > On Wed, 2006-01-18 at 19:41 -0800, Andrew Morton wrote:
> >  > > Adrian Bunk <bunk@stusta.de> wrote:
> >  > > >
> >  > > > Let's do the scheduled removal of the obsolete raw driver in 2.6.17.
> >  > > > 
> >  > > 
> >  > > heh.  I was just thinking that I hadn't heard from Badari and Ken in a while.
> >  > > 
> >  > > I doubt if this'll fly.  We're stuck with it.
> >  > 
> >  > One thing we can do is ask the distributions to stop shipping raw first,
> >  > to see what the fallout is (and to give it as a sign that it's an
> >  > obsolete interface). Then a  year or two after that....
> > 
> > It's been off in Fedora since FC4.
> > RHEL4 had it enabled after several vendors complained a lot about its
> > absense breaking an installed userbase, though they were told it would be
> > enabled with the proviso that it would go away in the future.
> > RHEL5 isn't even in beta yet, but I can already hear the voices asking
> > for it be reenabled..
> > 
> 
> Thanks for trying though ;) It's good that RH is helping to push things
> along like this - the easiest path would be to turn the thing on and
> complain when anyone made noises about taking it out.

another thing we really should do is making such "obsolete to be phased
out" things printk (at least once per boot ;) so that people see it in
their logs, not just in the kernel source.

It's really useful to find culprits that way in distros (sometimes
there's apps that do the weirdest things).. but also a good sign to ISVs
that they should start investigating alternatives. Yes that takes a long
time, but that just means it's important to start warning them early...


