Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbULHSnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbULHSnw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbULHSnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:43:52 -0500
Received: from modemcable166.48-200-24.mc.videotron.ca ([24.200.48.166]:54250
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S261282AbULHSnt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:43:49 -0500
Date: Wed, 8 Dec 2004 13:43:43 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george@mvista.com, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, clameter@sgi.com,
       len.brown@intel.com, linux@dominikbrodowski.de, davidm@hpl.hp.com,
       ak@suse.de, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max <amax@us.ibm.com>, mahuja@us.ibm.com
Subject: Re: [RFC] New timeofday proposal (v.A1)
In-Reply-To: <1102470914.1281.27.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0412081337150.3803@xanadu.home>
References: <1102470914.1281.27.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2004, john stultz wrote:

> Points I'm glossing over for now:
> ====================================================
> 
> o Some arches (arm, for example) do not have high res timing hardware

Just a note: The ARM architecture is rather a bunch of multiple 
subarchitectures sharing the same instruction set but with wildly 
different sets of peripherals.  Many of those ARM subarchitectures have 
high res (sub microsec) timer capabilities.


Nicolas
