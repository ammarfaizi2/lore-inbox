Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268731AbTGOQIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268685AbTGOQH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:07:56 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:30172 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S268827AbTGOQFL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:05:11 -0400
Date: Tue, 15 Jul 2003 09:19:51 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: video4linux-list@redhat.com, Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] sysfs'ify video4linux
Message-ID: <20030715091951.D6208@home.com>
References: <20030715143119.GB14133@bytesex.org> <1058282472.2238.75.camel@shrek.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1058282472.2238.75.camel@shrek.bitfreak.net>; from rbultje@ronald.bitfreak.net on Tue, Jul 15, 2003 at 05:21:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 05:21:13PM +0200, Ronald Bultje wrote:
> Hey Gerd,
> 
> On Tue, 2003-07-15 at 16:31, Gerd Knorr wrote:
> > This patch moves the video4linux subsystem from procfs to sysfs.
> [..cool stuff, especially the driver integration fanciness with the
> device struct stuff..]
> > Comments?
> 
> Is /proc going away alltogether?

Well, it does need to provide per-process info like it was originally
intended. It's all the device crap that doesn't belong there that is
moving.

Regards,
-- 
Matt Porter
mporter@kernel.crashing.org
