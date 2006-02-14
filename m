Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbWBNM7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWBNM7X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 07:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbWBNM7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 07:59:23 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:38123 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161042AbWBNM7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 07:59:22 -0500
Date: Tue, 14 Feb 2006 13:59:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
Subject: Re: [PATCH 00/12] hrtimer patches
In-Reply-To: <20060214123226.GA3138@elte.hu>
Message-ID: <Pine.LNX.4.61.0602141342390.30994@scrub.home>
References: <Pine.LNX.4.61.0602141057320.30994@scrub.home> <20060214110947.GA25341@elte.hu>
 <Pine.LNX.4.61.0602141228120.30994@scrub.home> <20060214123226.GA3138@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 14 Feb 2006, Ingo Molnar wrote:

> > It's two get_time() calls and I don't consider it noise, they are 
> > wasting time with unnecessary hardware accesses.
> 
> Nobody complained about it so far (other than you) or has measured it, 
> so IMO there's no pressing need and it's simply too late in the cycle to 
> touch core timer code like that. 2.6.16 is really cooling down now.

Well, most developer don't care about older hardware anymore, on recent 
hardware it's indeed a nonissue, so I'm not really suprised nobody 
complained.
For me the patch is important enough that it should be seriously 
considered for 2.6.16 and not just rejected like this. Sorry, that I'm a 
bit late, but the hrtimer was merged without warning and I can't just drop 
everything to fix other people's code.

bye, Roman
