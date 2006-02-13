Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWBMNnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWBMNnB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 08:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWBMNnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 08:43:00 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:24287 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750840AbWBMNnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 08:43:00 -0500
Date: Mon, 13 Feb 2006 14:42:46 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 01/13] hrtimer: round up relative start time
In-Reply-To: <20060213130143.GA10771@elte.hu>
Message-ID: <Pine.LNX.4.61.0602131441110.9696@scrub.home>
References: <Pine.LNX.4.61.0602130207560.23745@scrub.home>
 <1139827927.4932.17.camel@localhost.localdomain> <Pine.LNX.4.61.0602131208050.30994@scrub.home>
 <20060213130143.GA10771@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2006, Ingo Molnar wrote:

> but there is no 'old behavior' to restore to. The +1 to itimer intervals 
> caused artifacts that were hitting users and caused 2.4 -> 2.6 itimer 
> regressions, which hrtimers fixed. E.g.:
> 
>   http://bugzilla.kernel.org/show_bug.cgi?id=3289

Ingo, please read correctly, this is mainly about interval timers, which 
my patch doesn't change. My patch only fixes the initial start time.

bye, Roman
