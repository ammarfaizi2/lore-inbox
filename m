Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030500AbWHIFxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbWHIFxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 01:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030501AbWHIFxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 01:53:55 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:20611
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030499AbWHIFxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 01:53:54 -0400
Date: Tue, 08 Aug 2006 22:53:55 -0700 (PDT)
Message-Id: <20060808.225355.78711315.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: a.p.zijlstra@chello.nl, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, phillips@google.com
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060809054648.GD17446@2ka.mipt.ru>
References: <20060808193325.1396.58813.sendpatchset@lappy>
	<20060809054648.GD17446@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Wed, 9 Aug 2006 09:46:48 +0400

> There is another approach for that - do not use slab allocator for
> network dataflow at all. It automatically has all you pros amd if
> implemented correctly can have a lot of additional usefull and
> high-performance features like full zero-copy and total fragmentation
> avoidance.

Free advertisement for your network tree allocator Evgeniy? :-)

