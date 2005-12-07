Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVLGRSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVLGRSA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVLGRSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:18:00 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:20387 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751216AbVLGRSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:18:00 -0500
Date: Wed, 7 Dec 2005 18:17:43 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rostedt@goodmis.org, johnstul@us.ibm.com
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
In-Reply-To: <20051207165550.GA2426@elte.hu>
Message-ID: <Pine.LNX.4.61.0512071813540.1610@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0512061628050.1610@scrub.home> <1133908082.16302.93.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0512070347450.1609@scrub.home> <20051207165550.GA2426@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 7 Dec 2005, Ingo Molnar wrote:

> > A bit later ktime_t looked pretty much like the 64bit part of my 
> > ktimespec.
> 
> and Thomas credited you for that point in his announcement:
> 
>  " Roman pointed out that the penalty for some architectures
>    would be quite big when using the nsec_t (64bit) scalar time
>    storage format. "

"pointed out that the penalty" is a bit different from "provided the 
basic idea of the ktime_t union and half the implementation"...

bye, Roman
