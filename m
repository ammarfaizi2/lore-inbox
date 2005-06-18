Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVFRMCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVFRMCR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 08:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVFRMCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 08:02:17 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:58006 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261529AbVFRMCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 08:02:15 -0400
Date: Sat, 18 Jun 2005 14:02:05 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
In-Reply-To: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0506181344000.3743@scrub.home>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 17 Jun 2005, john stultz wrote:

> o Uses nanoseconds as the kernel's base time unit

Maybe I missed it, but was there ever a conclusive discussion about the 
perfomance impact this has?
I see lots of new u64 variables. I'm especially interested how this code 
scales down to small and slow machines, where such a precision is absolute 
overkill. How do these patches change current and possibly common time 
operations?

bye, Roman
