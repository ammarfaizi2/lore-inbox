Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVEOKBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVEOKBz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 06:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbVEOKBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 06:01:55 -0400
Received: from colin.muc.de ([193.149.48.1]:8715 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262661AbVEOKBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 06:01:48 -0400
Date: 15 May 2005 12:01:47 +0200
Date: Sun, 15 May 2005 12:01:47 +0200
From: Andi Kleen <ak@muc.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@redhat.com>, Matt Mackall <mpm@selenic.com>,
       Andy Isaacson <adi@hexapodia.org>,
       "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050515100147.GA72234@muc.de>
References: <20050513215905.GY5914@waste.org> <1116024419.20646.41.camel@localhost.localdomain> <1116025212.6380.50.camel@mindpipe> <20050513232708.GC13846@redhat.com> <1116027488.6380.55.camel@mindpipe> <1116084186.20545.47.camel@localhost.localdomain> <1116088229.8880.7.camel@mindpipe> <1116089068.6007.13.camel@laptopd505.fenrus.org> <1116093396.9141.11.camel@mindpipe> <1116093694.6007.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116093694.6007.15.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 08:01:33PM +0200, Arjan van de Ven wrote:
> On Sat, 2005-05-14 at 13:56 -0400, Lee Revell wrote:
> > On Sat, 2005-05-14 at 18:44 +0200, Arjan van de Ven wrote:
> > > then JACK is terminally broken if it doesn't have a fallback for non-
> > > rdtsc cpus. 
> > 
> > It does have a fallback, but the selection is done at compile time.  It
> > uses rdtsc for all x86 CPUs except pre-i586 SMP systems.
> > 
> > Maybe we should check at runtime,
> 
> it's probably a sign that JACK isn't used on SMP systems much, at least
> not on the bigger systems (like IBM's x440's) where the tsc *will*
> differ wildly between cpus...

It does not even need SMP, just use a Centrino laptop.

I suppose what the Jack guys are doing is to recommend to disable
frequency scaling then the sound guys complain again
that sound on linux is so hard to use. I wonder where this comes from? :)

-Andi
