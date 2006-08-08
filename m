Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbWHHWcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWHHWcH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 18:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWHHWcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 18:32:07 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:45454
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965054AbWHHWcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 18:32:05 -0400
Date: Tue, 08 Aug 2006 15:32:10 -0700 (PDT)
Message-Id: <20060808.153210.52118365.davem@davemloft.net>
To: auke-jan.h.kok@intel.com
Cc: a.p.zijlstra@chello.nl, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, phillips@google.com, jesse.brandeburg@intel.com
Subject: Re: [RFC][PATCH 3/9] e1000 driver conversion
From: David Miller <davem@davemloft.net>
In-Reply-To: <44D8F919.7000006@intel.com>
References: <20060808193325.1396.58813.sendpatchset@lappy>
	<20060808193355.1396.71047.sendpatchset@lappy>
	<44D8F919.7000006@intel.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Auke Kok <auke-jan.h.kok@intel.com>
Date: Tue, 08 Aug 2006 13:50:33 -0700

> can we really delete these??

netdev_alloc_skb() does it for you
