Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbULMTyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbULMTyC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 14:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbULMTwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:52:09 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:58868 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262278AbULMTfU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 14:35:20 -0500
Subject: Re: dynamic-hz
From: john stultz <johnstul@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, Con Kolivas <kernel@kolivas.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041213110852.GQ16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random>
	 <20041212163547.GB6286@elf.ucw.cz>
	 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
	 <20041212234256.GK6272@elf.ucw.cz>
	 <cone.1102896588.31702.10669.502@pc.kolivas.org>
	 <20041213104321.GB7340@elf.ucw.cz>
	 <20041213110852.GQ16322@dualathlon.random>
Content-Type: text/plain
Message-Id: <1102966592.1281.397.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 13 Dec 2004 11:36:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-13 at 03:08, Andrea Arcangeli wrote:
> On Mon, Dec 13, 2004 at 11:43:21AM +0100, Pavel Machek wrote:
> > Doing lot less per timer tick is not going to help much... You cpu
> 
> I also doubt we can do significantly less per timer tick. 

Well, I'd like see the timeofday timekeeping work reduced so we don't do
it every tick. Instead it would become a scheduled event that goes off
every second or so.

thanks
-john

