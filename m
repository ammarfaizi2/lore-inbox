Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbVLGMqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVLGMqw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbVLGMqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:46:52 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:17057 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750977AbVLGMqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:46:51 -0500
Date: Wed, 7 Dec 2005 13:40:53 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
       johnstul@us.ibm.com
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
In-Reply-To: <4396C2EB.1000203@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0512071335180.1609@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0512061628050.1610@scrub.home> <1133908082.16302.93.camel@tglx.tec.linutronix.de>
 <20051207013122.3f514718.akpm@osdl.org> <20051207101137.GA25796@elte.hu>
 <4396B81E.4030605@yahoo.com.au> <20051207104900.GA26877@elte.hu>
 <4396C2EB.1000203@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 7 Dec 2005, Nick Piggin wrote:

> Sure... hmm, the names timeout and timer themselves have something
> vagely wrong about them, but I can't quite place my finger on it,
> not a real worry though...
> 
> Maybe it is that timeout is an end result, but timer is a mechanism.
> So maybe it should be 'struct interval', 'struct timeout';
> or 'struct timer', 'struct timeout_timer'.
> 
> But I don't know really, it isn't a big deal.

Nick, thanks for speaking up about this.
My mistake was to make a big deal out of it, because I knew it would 
confuse more people. After I got the heat for this, it seems nobody else 
want to get flamed for it.

bye, Roman
