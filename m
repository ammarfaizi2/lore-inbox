Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbTDITVr (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 15:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbTDITVq (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 15:21:46 -0400
Received: from pop.gmx.de ([213.165.65.60]:23551 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263734AbTDITVq (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 15:21:46 -0400
From: "Oliver S." <Follow.Me@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: questions regarding Journalling-FSes and w-cache reordering
Date: Wed, 9 Apr 2003 21:33:20 +0200
Message-ID: <000901c2fece$e2801c80$0200000a@kimba>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a question regarding the behaviour of w-caches with ATA-harddisks:
Is a ATA-harddisk allowed to reorder the operations from in w-cache ? On one
side, this would be an opportunity to optimize head-movements (although a good
cyclical-scan drive-scheduler would gain the same if it can rely on a linear
sector-mapping), but on the other side, this would compromise the two-phase
commiting of journalling FSes and render it useless. So I doubt that reorder-
ing is allowed with ATA-HDs. Are my assumptions right ?

