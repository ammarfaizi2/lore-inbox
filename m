Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWBFKNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWBFKNN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWBFKNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:13:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40398 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750817AbWBFKNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:13:12 -0500
Date: Mon, 6 Feb 2006 11:11:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060206101156.GA1761@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <20060206001959.394b33bc.pj@sgi.com> <20060206082258.GA1991@elte.hu> <200602061109.45788.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602061109.45788.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> Of course there might be some corner cases where using local memory 
> for caching is still better (like mmap file IO), but my guess is that 
> it isn't a good default.

/tmp is almost certainly one where local memory is better.

	Ingo
