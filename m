Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbVIQEbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVIQEbK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 00:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbVIQEbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 00:31:10 -0400
Received: from [212.76.86.230] ([212.76.86.230]:36356 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750890AbVIQEbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 00:31:08 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Eradic disk access during reads
Date: Sat, 17 Sep 2005 07:26:11 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509170717.03439.a1426z@gawab.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Monitoring disk access using gkrellm, I noticed that a command like

cat /dev/hda > /dev/null

shows eradic disk reads ranging from 0 to 80MB/s on an otherwise idle system.

1. Is this a hardware or software problem?
2. Is there a lightweight perf-mon tool (cmd-line) that would log this 
behaviour graphically?

Thanks!

--
Al

