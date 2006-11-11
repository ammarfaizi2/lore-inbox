Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946861AbWKKAty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946861AbWKKAty (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 19:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424471AbWKKAty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 19:49:54 -0500
Received: from ensim03.ffm.m2soft.com ([195.38.20.12]:24271 "EHLO
	ensim03.ffm.m2soft.com") by vger.kernel.org with ESMTP
	id S1424469AbWKKAtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 19:49:53 -0500
X-ClientAddr: 85.127.134.150
Date: Sat, 11 Nov 2006 01:47:56 +0100
From: Nicolas Kaiser <nikai@nikai.net>
To: linux-ide@vger.kernel.org
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL] drivers/ide: stray bracket
Message-ID: <20061111014756.3467d7ee@lucky.kitzblitz>
Organization: -
X-Face: "fF&[w2"Nws:JNH4'g|:gVhgGKLhj|X}}&w&V?]0=,7n`jy8D6e[Jh=7+ca|4~t5e[ItpL5
 N'y~Mvi-vJm`"1T5fi1^b!&EG]6nW~C!FN},=$G?^U2t~n[3;u\"5-|~H{-5]IQ2
X-Mailer: Sylpheed-claws (Linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-M2Soft-MailScanner-Information: Please contact the ISP for more information
X-M2Soft-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-From: nikai@nikai.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stray bracket in debug code.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---

 drivers/ide/legacy/hd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -uprN a/drivers/ide/legacy/hd.c b/drivers/ide/legacy/hd.c
--- a/drivers/ide/legacy/hd.c	2006-09-20 05:42:06.000000000 +0200
+++ b/drivers/ide/legacy/hd.c	2006-11-10 21:52:20.000000000 +0100
@@ -459,7 +459,7 @@ ok_to_read:
 #ifdef DEBUG
 	printk("%s: read: sector %ld, remaining = %ld, buffer=%p\n",
 		req->rq_disk->disk_name, req->sector, req->nr_sectors,
-		req->buffer+512));
+		req->buffer+512);
 #endif
 	if (req->current_nr_sectors <= 0)
 		end_request(req, 1);
