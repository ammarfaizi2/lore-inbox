Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWI2W0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWI2W0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 18:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWI2W0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 18:26:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27538 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750846AbWI2W0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 18:26:42 -0400
Date: Fri, 29 Sep 2006 18:24:10 -0400
From: Dave Jones <davej@redhat.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: jt@hpl.hp.com, "John W. Linville" <linville@tuxdriver.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-git9 wireless fixes break ipw2200 association to AP with WPA
Message-ID: <20060929222410.GI22014@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alessandro Suardi <alessandro.suardi@gmail.com>, jt@hpl.hp.com,
	"John W. Linville" <linville@tuxdriver.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <5a4c581d0609291225r4a2cbaacr35e5ef73d69f8718@mail.gmail.com> <20060929202928.GA14000@tuxdriver.com> <5a4c581d0609291340q835571bg9657ac0a68bab20e@mail.gmail.com> <20060929212748.GA10288@bougret.hpl.hp.com> <5a4c581d0609291504r40bc1796q715c5ffa41aa7b1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4c581d0609291504r40bc1796q715c5ffa41aa7b1b@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 12:04:31AM +0200, Alessandro Suardi wrote:

 > Even if so, wireless-tools would be the only package I have to
 >  build out of the FC5 distribution to keep up with the latest -git
 >  snapshot of the Torvalds kernel... I'm not especially troubled
 >  with this anyway. Perhaps you could push the Fedora folks to
 >  be a bit more up-to-date with wireless-tools in their current
 >  main version ?

We do. Frequently, because it tends to break in some manner every
single time we push a rebased kernel update.
wireless-tools v28 is in the updates repo right now, which afaik, is
already the newest available.

It's seriously unfunny to have to update fundamental userspace packages
like this when moving to a newer kernel. Especially when say for eg,
the newer kernel then has a broken sound driver, so the user goes
back to their old 'working' kernel. Oops, now they have a choice
of a kernel with broken sound, or a kernel with broken wireless.


	Dave

