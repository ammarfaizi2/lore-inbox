Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVGPNyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVGPNyd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 09:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVGPNvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 09:51:49 -0400
Received: from cpu2485.adsl.bellglobal.com ([207.236.16.208]:29419 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261579AbVGPNuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 09:50:24 -0400
Date: Fri, 15 Jul 2005 14:17:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Chris Wedgwood <cw@f00f.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       arjan@infradead.org, azarah@nosferatu.za.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050715121748.GB1775@elf.ucw.cz>
References: <20050708145953.0b2d8030.akpm@osdl.org> <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe> <1120933916.3176.57.camel@laptopd505.fenrus.org> <1120934163.6488.72.camel@mindpipe> <20050709121212.7539a048.akpm@osdl.org> <1120936561.6488.84.camel@mindpipe> <1121088186.7407.61.camel@localhost.localdomain> <20050711140510.GB14529@thunk.org> <20050711160205.GA6834@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050711160205.GA6834@taniwha.stupidest.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The real answer here is for the tickless patches to cleaned up to
> > the point where they can be merged, and then we won't waste battery
> > power entering the timer interrupt in the first place.  :-)
> 
> Whilst conceptually this is a nice idea I've yet to see any viable
> code that overall has a lower cost.  Tickless is a really nice idea
> for embedded devices and also paravirtualized hardware but I don't
> think anyone has it working well enough yet do they?

Actually for power managment uses, "NO_IDLE_HZ" seems to be enough,
and that is both implemented and working.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
