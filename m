Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVECE1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVECE1u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 00:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVECE1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 00:27:50 -0400
Received: from waste.org ([216.27.176.166]:4559 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261385AbVECE1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 00:27:47 -0400
Date: Mon, 2 May 2005 21:27:39 -0700
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Morten Welinder <mwelinder@gmail.com>,
       Sean <seanlkml@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Message-ID: <20050503042739.GF22038@waste.org>
References: <20050429165232.GV21897@waste.org> <427650E7.2000802@tmr.com> <Pine.LNX.4.58.0505021457060.3594@ppc970.osdl.org> <20050502223002.GP21897@waste.org> <Pine.LNX.4.58.0505021540070.3594@ppc970.osdl.org> <20050503000011.GA22038@waste.org> <Pine.LNX.4.58.0505022123270.3594@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505022123270.3594@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 09:24:54PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 2 May 2005, Matt Mackall wrote:
> > 
> > It's still simple in Mercurial, but more importantly Mercurial _won't
> > need it_. Dropping history is a work-around, not a feature.
> 
> Side note: this is what Larry thought about BK too. Until three years had
> passed, and the ChangeSet file was many megabytes in size. Even slow
> growth ends up being big growth in the end..
> 
> We had been talking about pruning the BK history as long back as a year 
> ago.

Ok, I'll implement it on my red eye flight tonight. But Mercurial
won't suffer from the O(filesize) problem of BK.

-- 
Mathematics is the supreme nostalgia of our time.
