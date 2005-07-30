Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263016AbVG3Ilp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbVG3Ilp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 04:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbVG3Ilp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 04:41:45 -0400
Received: from mail1.nwe.de ([195.226.126.83]:40161 "EHLO mail1.nwe.de")
	by vger.kernel.org with ESMTP id S263016AbVG3Ilo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 04:41:44 -0400
Date: Sat, 30 Jul 2005 10:41:07 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@localhost
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6-mm] tms380tr: remove prototypes in Space.c
Message-ID: <Pine.LNX.4.58.0507301039430.5597@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jochen Friedrich <jochen@scram.de>

Cleanup: remove two prototypes.

---
commit 12dd61e649920ddc5164971e36ed2a6aeb300708
tree 2558f9767b0fa94b31bd6fe8de67cb17cab7e8df
parent 6407300cd8c7368f6bfcaa476e4dd50ce7421ab2
author Jochen Friedrich <jochen@scram.de> Fri, 29 Jul 2005 20:39:49 +0200
committer Jochen Friedrich <jochen@scram.de> Fri, 29 Jul 2005 20:39:49 +0200

 drivers/net/Space.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/net/Space.c b/drivers/net/Space.c
--- a/drivers/net/Space.c
+++ b/drivers/net/Space.c
@@ -318,8 +318,6 @@ static void __init ethif_probe2(int unit
 #ifdef CONFIG_TR
 /* Token-ring device probe */
 extern int ibmtr_probe_card(struct net_device *);
-extern struct net_device *sk_isa_probe(int unit);
-extern struct net_device *proteon_probe(int unit);
 extern struct net_device *smctr_probe(int unit);

 static struct devprobe2 tr_probes2[] __initdata = {

-- 
Bug, n.:
An aspect of a computer program which exists because the
programmer was thinking about girls or stock options when he
wrote the program.

