Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWDGFAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWDGFAO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 01:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWDGFAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 01:00:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49354
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932256AbWDGFAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 01:00:11 -0400
Date: Thu, 06 Apr 2006 21:59:54 -0700 (PDT)
Message-Id: <20060406.215954.06812450.davem@davemloft.net>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: kamezawa.hiroyu@jp.fujitsu.com, jbarnes@sgi.com, jes@trained-monkey.org,
       nickpiggin@yahoo.com.au, tony.luck@intel.com,
       mm-commits@vger.kernel.org
Subject: Re: + pg_uncached-is-ia64-only.patch added to -mm tree
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060406215242.245340de.akpm@osdl.org>
References: <200604070421.k374LXFs011197@shell0.pdx.osdl.net>
	<20060407134827.91a47e69.kamezawa.hiroyu@jp.fujitsu.com>
	<20060406215242.245340de.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Thu, 6 Apr 2006 21:52:42 -0700

> It's easier to change FLAGS_RESERVED ;)

It reminds me that I need to do something about the fact that
Sparc64 makes use of bits 24-->32 currently to record the cpu
that performs cpu stores into and thus dirties the D-cache for
a pagecache page.
