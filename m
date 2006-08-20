Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWHTRK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWHTRK6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWHTRK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:10:58 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:25323 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750974AbWHTRK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:10:58 -0400
Date: Sun, 20 Aug 2006 19:10:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       linux-kernel@vger.kernel.org, Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: Linux time code
In-Reply-To: <1155851917.31755.125.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0608201906410.6761@scrub.home>
References: <44E32B23.16949.BBB1EC4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
  <1155758034.5513.69.camel@localhost.localdomain>  <Pine.LNX.4.64.0608171334030.6761@scrub.home>
 <1155851917.31755.125.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 17 Aug 2006, john stultz wrote:

> > What is missing is the abiltity to map a clock to a posix clock, so that 
> > you would have CLOCK_REALTIME/CLOCK_MONOTONIC as NTP controlled clocks and 
> > other CLOCK_* as the raw clock.
> 
> Is there a use case for this (wanting non-NTP corrected time on a system
> running NTPd) you have in mind?

Most are probably special cases, but a more general use would be to allow
tracking the stability of multiple clocks, so you can check which is most 
suited for a time server. So far you can only do it for one clock at a 
time and you have to turn off NTP for calibration.

bye, Roman
