Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWHTROb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWHTROb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWHTROb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:14:31 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:26603 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750995AbWHTROa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:14:30 -0400
Date: Sun, 20 Aug 2006 19:14:22 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       linux-kernel@vger.kernel.org, Udo van den Heuvel <udovdh@xs4all.nl>
Subject: Re: Linux time code
In-Reply-To: <1155855768.31755.138.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0608201910480.6761@scrub.home>
References: <44E32B23.16949.BBB1EC4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
  <200608171512.00417.jbarnes@virtuousgeek.org>  <1155853964.31755.131.camel@cog.beaverton.ibm.com>
  <200608171550.31097.jbarnes@virtuousgeek.org> <1155855768.31755.138.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 17 Aug 2006, john stultz wrote:

> > Hm, I guess that's ok for most of the timestamp applications I'm aware of 
> > as long as NTP won't cause the clock to stand still...
> 
> Nope. Its limited to a +/-500ppm adjustment max.

This is only frequency adjustment, time adjustment is added as well which 
can be much larger than this.

bye, Roman
