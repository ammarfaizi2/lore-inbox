Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752330AbWAFAcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbWAFAcQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbWAFAcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:32:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3463 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752276AbWAFAcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:32:13 -0500
Date: Thu, 5 Jan 2006 16:27:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Martin Bligh <mbligh@mbligh.org>, Matt Mackall <mpm@selenic.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
In-Reply-To: <20060106001519.GA15520@elte.hu>
Message-ID: <Pine.LNX.4.64.0601051626290.3169@g5.osdl.org>
References: <1136463553.2920.22.camel@laptopd505.fenrus.org>
 <20060105170255.GK3356@waste.org> <43BD5E6F.1040000@mbligh.org>
 <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org>
 <43BD784F.4040804@mbligh.org> <Pine.LNX.4.64.0601051208510.3169@g5.osdl.org>
 <Pine.LNX.4.64.0601051213270.3169@g5.osdl.org> <20060105233049.GA3441@elte.hu>
 <Pine.LNX.4.64.0601051548290.3169@g5.osdl.org> <20060106001519.GA15520@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Jan 2006, Ingo Molnar wrote:
>
> Especially if there enough profiling hits, it's usually a quick glance 
> to figure out the hotpath:

Ehh. What's a "quick glance" to a human can be quite hard to automate. 
That's my point.

If we do the "human quick glances", we won't be seeing much come out of 
this. That's what we've already been doing, for several years.

I thought the discussion was about trying to automate this..

		Linus
