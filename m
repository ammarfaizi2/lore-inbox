Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWAJXUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWAJXUT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWAJXUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:20:19 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:34526 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751131AbWAJXUR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:20:17 -0500
Subject: Re: [PATCH 1/10] NTP: Remove pps support
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0512220019330.30882@scrub.home>
References: <Pine.LNX.4.61.0512220019330.30882@scrub.home>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 15:20:10 -0800
Message-Id: <1136935211.2890.11.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 00:20 +0100, Roman Zippel wrote:
> This removes the support for pps. It's completely unused within the
> kernel and is basically in the way for further cleanups. It should be
> easier to readd proper support for it after the rest has been converted
> to NTP4.
> Patch is originally done by John Stultz, I did some minor cleanups and
> updated it.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

Hey Roman, sorry for the slow response, but I've been busy since getting
back from the holiday.

Initially when I wrote this I was hoping to prod Ulrich into updating
and sending his PPS driver for inclusion. But I believe he has just been
too busy, so pulling this code is probably the right thing. 

Acked-by: John Stultz <johnstul@us.ibm.com>


I do hope someone interested in PPS drivers will re-add the support code
along with a driver that utilizes the interface at some point.

thanks
-john

