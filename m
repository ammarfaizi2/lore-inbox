Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWEBTms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWEBTms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWEBTms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:42:48 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:20096 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751141AbWEBTmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:42:47 -0400
Date: Tue, 2 May 2006 21:47:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060502194734.GA10072@elte.hu>
References: <20060419112130.GA22648@elte.hu> <200605021703.37195.ak@suse.de> <44577822.8050103@mbligh.org> <200605021745.32907.ak@suse.de> <4457829E.6090901@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4457829E.6090901@mbligh.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Martin J. Bligh <mbligh@mbligh.org> wrote:

> > i only booted it on a non-NUMA PC. Most likely the instability is
> > caused by some sort of zone mis-sizing. (See more details in this
> > same thread.)
> 
> Ooooh, on ordinary PCs. that makes more sense.

btw., NUMA emulation on 64-bit had problems too on and off (no problems 
currently), so i'm not surprised that 32-bit NUMA has problems on 
non-NUMA boxes. It would still be useful to have it, because that way 
the NUMA codepaths can be excercised.

	Ingo
