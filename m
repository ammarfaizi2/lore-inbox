Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbVKYHjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVKYHjk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 02:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVKYHjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 02:39:40 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:20374 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1750859AbVKYHjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 02:39:39 -0500
X-ORBL: [70.132.51.62]
Date: Thu, 24 Nov 2005 23:38:54 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051125073854.GA16771@taniwha.stupidest.org>
References: <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 01:36:08PM -0800, Linus Torvalds wrote:

> Actual UP machines are going to go away - even ARM is going SMP, and
> in the PC space, we'll have multi-core laptops probably being the
> rule rather than the exception in a couple of years.

CPUs in embedded the space could outnumber desktops & servers greatly
(cell phones, access pointers, routers, media players, etc).  Most of
these will be UP for some time.
