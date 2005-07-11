Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVGKQDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVGKQDl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVGKQDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:03:35 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:39118 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262142AbVGKQCQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:02:16 -0400
X-ORBL: [63.202.173.158]
Date: Mon, 11 Jul 2005 09:02:05 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "Theodore Ts'o" <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       arjan@infradead.org, azarah@nosferatu.za.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050711160205.GA6834@taniwha.stupidest.org>
References: <20050708214908.GA31225@taniwha.stupidest.org> <20050708145953.0b2d8030.akpm@osdl.org> <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe> <1120933916.3176.57.camel@laptopd505.fenrus.org> <1120934163.6488.72.camel@mindpipe> <20050709121212.7539a048.akpm@osdl.org> <1120936561.6488.84.camel@mindpipe> <1121088186.7407.61.camel@localhost.localdomain> <20050711140510.GB14529@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050711140510.GB14529@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 10:05:10AM -0400, Theodore Ts'o wrote:

> The real answer here is for the tickless patches to cleaned up to
> the point where they can be merged, and then we won't waste battery
> power entering the timer interrupt in the first place.  :-)

Whilst conceptually this is a nice idea I've yet to see any viable
code that overall has a lower cost.  Tickless is a really nice idea
for embedded devices and also paravirtualized hardware but I don't
think anyone has it working well enough yet do they?
