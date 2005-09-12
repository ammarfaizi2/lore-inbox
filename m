Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbVILO7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbVILO7M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVILO7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:59:10 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:25095 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751359AbVILO7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:59:07 -0400
Date: Mon, 12 Sep 2005 10:48:58 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, akpm@osdl.org, john.ronciak@intel.com,
       ganesh.venkatesan@intel.com, cramerj@intel.com,
       jesse.brandeburg@intel.com, ayyappan.veeraiyan@intel.com,
       mchan@broadcom.com, davem@davemloft.net
Subject: [patch 2.6.13 0/5] normalize calculations of rx_dropped
Message-ID: <09122005104858.332@bilbo.tuxdriver.com>
In-Reply-To: <20050822181726.GJ2736@tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some fixes to normalize how rx_dropped is calculated.  This is the
product of a discussion on netdev on or about 18 August 2005 w/
the subject '[RFC] stats: how to count "good" packets dropped by
hardware?'

Patches for 3c59x, e1000, e100, ixgb, and tg3 to follow.
