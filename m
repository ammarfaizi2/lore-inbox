Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVDORYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVDORYU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 13:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVDORYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 13:24:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:54238 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261875AbVDORYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 13:24:16 -0400
Date: Fri, 15 Apr 2005 19:24:08 +0200
From: Andi Kleen <ak@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Hugh Dickins <hugh@veritas.com>,
       Dave Jones <davej@redhat.com>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
Message-ID: <20050415172408.GB8511@wotan.suse.de>
References: <20050330214455.GF10159@redhat.com> <20050331104117.GD1623@wotan.suse.de> <20050407024902.GA9017@redhat.com> <20050407062928.GH24469@wotan.suse.de> <Pine.LNX.4.61.0504141419250.25074@goblin.wat.veritas.com> <20050414170117.GD22573@wotan.suse.de> <Pine.LNX.4.61.0504141804480.26008@goblin.wat.veritas.com> <20050414181015.GH22573@wotan.suse.de> <20050414181133.GA18221@wotan.suse.de> <20050414182712.GG493@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414182712.GG493@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 11:27:12AM -0700, Chris Wright wrote:
> * Andi Kleen (ak@suse.de) wrote:
> > > I will take a closer look at the rc1/rc2 patches later this evening
> > > and see if I can spot something. Can only report back tomorrow though.
> > 
> > Actually itt started in .11 already - sigh - on rereading the thread.
> > That will make the code audit harder :/
> 
> Yes, I've seen it in .11 and earlier kernels.  Happen to have same
> "x86_64" string on my bad pmd dumps, but can't reproduce it at all.
> So, for now, I can hold off on adding the reload cr3 patch to -stable
> unless you think it should be there anyway.

It is a bug fix (actually there is another related patch that fixes
a similar bug), but we lived with the problems for years so I guess
they can wait for .12. 

If there was a fix for the bad pmd problem it might be a candidate
for stable, but so far we dont know what causes it yet.

-Andi
