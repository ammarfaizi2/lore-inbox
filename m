Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265691AbUEZQwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUEZQwA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 12:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbUEZQwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 12:52:00 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1664 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265691AbUEZQvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 12:51:38 -0400
Date: Wed, 26 May 2004 17:58:44 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405261658.i4QGwiYX000121@81-2-122-30.bradfords.org.uk>
To: "David Schwartz" <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEAEMEAA.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKMEAEMEAA.davids@webmaster.com>
Subject: RE: why swap at all?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	A lot of people feel subjectively that swap makes a system slow. There's
> anecdotal evidence that swap does horrible things or "must be badly broken
> because the machine gets slow" on almost every operating system that
> supports swapping. In most cases, it's just a case where the real working
> set has exceeded physical memory, and in that case, swap is just doing what
> it's supposed to be doing.

It's true that physical RAM or swap, over and above the minimum needed for
the working set is usually beneficial.  However where there is physical RAM
which will never be touched during normal usage, adding swap will not be
beneficial.

John.
