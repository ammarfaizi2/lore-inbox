Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVAaHp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVAaHp0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVAaHol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:44:41 -0500
Received: from waste.org ([216.27.176.166]:58860 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261944AbVAaHfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:35:01 -0500
Date: Mon, 31 Jan 2005 01:34:19 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.com>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
Message-Id: <1.416337461@selenic.com>
Subject: [PATCH 0/8] lib/sort: Add generic sort to lib/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces a generic heapsort function, sort(), in
lib/. It also replaces the uses of the recently introduced qsort()
code from glibc and then removes that code. A few other open-coded
sort routines are updated as well. I plan to clean up some other
effervescent sort routines in the near future.
