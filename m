Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWHRIaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWHRIaj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWHRIaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:30:39 -0400
Received: from ns.suse.de ([195.135.220.2]:16602 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751213AbWHRIa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:30:28 -0400
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.18-rc4-mm1 - time moving at 3x speed!
Date: Fri, 18 Aug 2006 11:34:02 +0200
User-Agent: KMail/1.9.1
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060813012454.f1d52189.akpm@osdl.org> <20060817224448.GB3616@aitel.hist.no> <1155856550.31755.142.camel@cog.beaverton.ibm.com>
In-Reply-To: <1155856550.31755.142.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608181134.02427.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 August 2006 01:15, john stultz wrote:
> On Fri, 2006-08-18 at 00:44 +0200, Helge Hafting wrote:
> > I got 2.6.18-rc4-mm1 going, and it appears that system
> > moves at about 3x normal speed.  A software clock need 3
> > seconds to advance 10 seconds, for example.
> >
> > Everything else seems faster too, the keyboard autorepeat,
> > delay loops in games, and so on.
> >
> > Guess I could live with this, if it'd also compile
> > 3x faster. :-/
> >
> > This is a x86-64 kernel, with the jiffies hotfix applied.
>
> Sounds like the same issue Gregorie Favre is dealing with.
>
> Please send full dmesg output.
>
> Does 2.6.18-rc4, or 2.6.18-rc3-mm2 have this issue

FWIW i looked through the x86-64 patch changes between
rc3-mm2 and rc4-mm1 and I can't find anything that would be remotely
related to the timer.

If it's confirmed to have regressed in this time it would require a binary 
search to track down I think.

-Andi
