Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269367AbUJWDFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269367AbUJWDFP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269284AbUJWDDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 23:03:08 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:6359 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269681AbUJWCwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 22:52:39 -0400
Subject: Re: 2.6.9-ck1: swap mayhem under UT2004
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Alastair Stevens <alastair@altruxsolutions.co.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <41799FE0.1020403@kolivas.org>
References: <200410222346.32823.alastair@altruxsolutions.co.uk>
	 <41799FE0.1020403@kolivas.org>
Content-Type: text/plain
Date: Fri, 22 Oct 2004 22:52:37 -0400
Message-Id: <1098499957.9092.19.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 10:03 +1000, Con Kolivas wrote:
> > Any ideas?  Any more info required?
> 
> I've seen reports of this happening since 2.6.9 _even on mainline_. 
> Something seems very sick with kswapd where it consumes massive amounts 
> of cpu. Can you reproduce without any -ck patches? Others have already 
> done so, but it seems to happen earlier with -ck.

One thing that comes to mind immediately is AM's patch to optimize the
swap space layout:

http://lkml.org/lkml/2004/9/9/254

This is definitely in mainline now, not sure when it went in.  Try
backing it out.

Lee

