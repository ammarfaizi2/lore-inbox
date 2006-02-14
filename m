Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161044AbWBNNVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbWBNNVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 08:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbWBNNVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 08:21:12 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:48107 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161044AbWBNNVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 08:21:12 -0500
Date: Tue, 14 Feb 2006 14:21:04 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: time patches by Roman Zippel
In-Reply-To: <43F195DF.23967.551458C@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Message-ID: <Pine.LNX.4.61.0602141400140.9696@scrub.home>
References: <43F195DF.23967.551458C@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 14 Feb 2006, Ulrich Windl wrote:

> 15_time_offset and 18_time_freq change some well-known constants (like MAXPHASE)
> by three orders of magnitude.
> 
> the new adjtime() (16_time_adjust, 12_time_adj) changes the semantics: Since about
> Linux 0.99, adjtime() had the adjtime_is_accurate property, i.e. on the long term
> it behaved like an addition.

I disagree, could you please explain how you come to this conclusion?
The patches don't change the behaviour beyond that they increase 
resolution and precision. Only the final patch changes the ntp code to 
match the behaviour of ntp reference code without including all its mess.

bye, Roman
