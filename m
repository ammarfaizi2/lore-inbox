Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWC3INF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWC3INF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWC3INE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:13:04 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:25534 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932092AbWC3IND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:13:03 -0500
Date: Thu, 30 Mar 2006 10:12:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: beware <wimille@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Float numbers in module programming
In-Reply-To: <442AA2A4.5010104@aitel.hist.no>
Message-ID: <Pine.LNX.4.61.0603301011220.30783@yvahk01.tjqt.qr>
References: <3fd7d9680603290634n6fabcdc7r193c30447acc1858@mail.gmail.com>
 <442AA2A4.5010104@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you need a few computations, try to do it with fixed point
> instead if at all possible. Or emulate floating point,
> or have a userspace helper app to do it.

Or try to transform it into integer math, if the precision loss is 
acceptable and no integer overflow can occur.


Jan Engelhardt
-- 
