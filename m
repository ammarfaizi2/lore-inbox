Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVAaHZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVAaHZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVAaHZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:25:57 -0500
Received: from waste.org ([216.27.176.166]:9196 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261934AbVAaHZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:25:54 -0500
Date: Mon, 31 Jan 2005 01:25:51 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
Message-Id: <1.687457650@selenic.com>
Subject: [PATCH 0/8] base-small: CONFIG_BASE_SMALL for small systems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduced a new pair of CONFIG_EMBEDDED options call
CONFIG_BASE_FULL/CONFIG_BASE_SMALL. Disabling CONFIG_BASE_FULL sets
the boolean CONFIG_BASE_SMALL to 1 and it is used to shrink a number
of core data structures. The space savings for the current batch is
around 14k.
