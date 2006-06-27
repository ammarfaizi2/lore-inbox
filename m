Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWF0FIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWF0FIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 01:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030656AbWF0Ei4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:38:56 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:19419 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030667AbWF0Eir
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:38:47 -0400
From: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Jun 2006 14:38:46 +1000
Subject: [Suspend2][ 00/10] Suspend2 Atomic Copy Patches
Message-Id: <20060627043846.14546.75810.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This set of patches contains routeines in kernel/power/atomic_copy.c.

These are routines to doing the atomic copy and restoration of data. When
resuming, most of the work is done by the swsusp lowlevel code, but we
still need to generate the pbes it uses from our bitmaps.
