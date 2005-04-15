Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVDOR2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVDOR2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 13:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVDOR2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 13:28:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:44731 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261878AbVDOR2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 13:28:34 -0400
Date: Fri, 15 Apr 2005 10:28:16 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Dave Jones <davej@redhat.com>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
Message-ID: <20050415172816.GU493@shell0.pdx.osdl.net>
References: <20050331104117.GD1623@wotan.suse.de> <20050407024902.GA9017@redhat.com> <20050407062928.GH24469@wotan.suse.de> <Pine.LNX.4.61.0504141419250.25074@goblin.wat.veritas.com> <20050414170117.GD22573@wotan.suse.de> <Pine.LNX.4.61.0504141804480.26008@goblin.wat.veritas.com> <20050414181015.GH22573@wotan.suse.de> <20050414181133.GA18221@wotan.suse.de> <20050414182712.GG493@shell0.pdx.osdl.net> <20050415172408.GB8511@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050415172408.GB8511@wotan.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen (ak@suse.de) wrote:
> On Thu, Apr 14, 2005 at 11:27:12AM -0700, Chris Wright wrote:
> > Yes, I've seen it in .11 and earlier kernels.  Happen to have same
> > "x86_64" string on my bad pmd dumps, but can't reproduce it at all.
> > So, for now, I can hold off on adding the reload cr3 patch to -stable
> > unless you think it should be there anyway.
> 
> It is a bug fix (actually there is another related patch that fixes
> a similar bug), but we lived with the problems for years so I guess
> they can wait for .12. 

Sounds good.

> If there was a fix for the bad pmd problem it might be a candidate
> for stable, but so far we dont know what causes it yet.

If I figure a way to trigger here, I'll report back.

thanks,
-chris
