Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270092AbTGaXKk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270576AbTGaXKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:10:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55798 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S270092AbTGaXKg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:10:36 -0400
Subject: Re: [PATCH] protect migration/%d etc from sched_setaffinity
From: Robert Love <rml@tech9.net>
To: Joe Korty <joe.korty@ccur.com>
Cc: torvalds@osdl.org, akpm@digeo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030731230635.GA7852@rudolph.ccur.com>
References: <20030731224604.GA24887@tsunami.ccur.com>
	 <1059692548.931.329.camel@localhost>
	 <20030731230635.GA7852@rudolph.ccur.com>
Content-Type: text/plain
Message-Id: <1059693499.786.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-5) 
Date: 31 Jul 2003 16:18:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-31 at 16:06, Joe Korty wrote:

> It's not all system daemons, just some of them that need protection.
> 
> Keeping the set of locked-down daemons to the smallest possible is
> important when one wants to 'set aside' cpus for use only by
> specific, need-the-lowest-latency-possible realtime applications.

Yah, I know. But this is a lot of code just to prevent root from hanging
herself, and she has plenty of other ways with which to do that.

	Robert Love


