Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422935AbWHZADH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422935AbWHZADH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 20:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422933AbWHZADG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 20:03:06 -0400
Received: from mga06.intel.com ([134.134.136.21]:59488 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1422927AbWHZADE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 20:03:04 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,170,1154934000"; 
   d="scan'208"; a="115152374:sNHT15139432"
Message-Id: <20060826000227.818796000@linux.intel.com>
User-Agent: quilt/0.45-1
Date: Fri, 25 Aug 2006 17:02:27 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 00/10] [TULIP] Tulip update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set includes all the non-controversial tulip patches from
the parisc tree, plus a few extra cleanups.  The major highlight is
the patch moving tulip_select_media() and its associated delay to a
work queue, a nice piece of work from Francois Romieu, with some
tweaks by Kyle McMartin.

-VAL
