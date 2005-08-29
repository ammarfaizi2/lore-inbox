Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbVH2RBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVH2RBN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbVH2RBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:01:13 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:29885 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750806AbVH2RBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:01:12 -0400
Date: Mon, 29 Aug 2005 10:00:41 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Alex Williamson <alex.williamson@hp.com>, george@mvista.com,
       john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Need better is_better_time_interpolator() algorithm
In-Reply-To: <20050827115531.GA1109@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.62.0508290955080.6012@schroedinger.engr.sgi.com>
References: <1124988269.5331.49.camel@tdi> <1124991406.20820.188.camel@cog.beaverton.ibm.com>
 <1124995405.5331.90.camel@tdi> <Pine.LNX.4.62.0508260827330.14463@schroedinger.engr.sgi.com>
 <1125073089.5182.30.camel@tdi> <430F6A7E.203@mvista.com> <1125084417.5182.58.camel@tdi>
 <Pine.LNX.4.62.0508261231440.16138@schroedinger.engr.sgi.com>
 <20050827115531.GA1109@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Aug 2005, Pavel Machek wrote:

> Usually is the key word here. Older APM stuff changes frequency behind
> your back, and sometimes frequency shift is time-critical.

In that case the clocks tied to the shifting frequency are
not usable.

