Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWIHSUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWIHSUd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWIHSUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:20:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:64339 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1751046AbWIHSUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:20:31 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,134,1157353200"; 
   d="scan'208"; a="123415611:sNHT29486002"
Message-Id: <20060908181533.771856000@linux.intel.com>
User-Agent: quilt/0.45-1
Date: Fri, 08 Sep 2006 11:15:33 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 00/10] [TULIP] Tulip update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend with bugs fixed.]

This patch set includes all the non-controversial tulip patches from
the parisc tree, plus a few extra cleanups.  The major highlight is
the patch moving tulip_select_media() and its associated delay to a
work queue, a nice piece of work from Francois Romieu, with some
tweaks by Kyle McMartin.

-VAL
