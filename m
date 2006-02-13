Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751690AbWBMJyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbWBMJyj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 04:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWBMJyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 04:54:39 -0500
Received: from mail.ccl.ru ([195.222.130.78]:43494 "EHLO mail.ccl.ru")
	by vger.kernel.org with ESMTP id S1751690AbWBMJyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 04:54:39 -0500
To: linux-kernel@vger.kernel.org
Subject: Linux swap speed suggestion
Message-Id: <E1F8Zdi-0001fl-00@porton.narod.ru>
From: "Victor Porton,,," <porton@ex-code.com>
Date: Mon, 13 Feb 2006 14:04:58 +0500
X-URL: http://porton.ex-code.com/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I strongly suggest to add the option whether to prefer to place swap at the
beginning or at the end of the swap partittion (leaving the other end free
when the swap usage is low).

This is useful for performance as the user could suggest to the kernel how to move the
HDD tracks less. For example I have swap partition before root partition and so would
want to put actual swap pages at the end of my swap partition to move HDD tracks less.

This should be option for both swapon command and for mkswap (to set the default for
swapon) command. (Instead of adding an option to swapon command, a kernel option may
be added.) (Imagine the situation of a swap partition BETWEEN two Linux root
partitions to understand why this should be configurable run-time, not only when doing
mkswap.)
