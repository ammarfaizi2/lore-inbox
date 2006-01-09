Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWAITQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWAITQR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWAITQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:16:17 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:18698 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750961AbWAITQP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:16:15 -0500
Date: Mon, 9 Jan 2006 20:16:17 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: cs89x0 warning in 2.6.15-git5
Message-Id: <20060109201617.6eaff677.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lennert,

Compiling cs89x0 as a module in 2.6.15-git5 produces the following
warning for me:

  CC [M]  drivers/net/cs89x0.o
drivers/net/cs89x0.c:186: warning: `netcard_portlist' defined but not used

No warning if the driver is build into the kernel.

I took a look at the code but it's a bit too, hm, messy for me to take
my chance at a clean fix. Still I thought I'd report is so that you at
least know about the problem.

Thanks,
-- 
Jean Delvare
