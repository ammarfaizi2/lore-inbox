Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWDXVZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWDXVZe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWDXVXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:23:55 -0400
Received: from mx.pathscale.com ([64.160.42.68]:36291 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751295AbWDXVXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:23:41 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 11 of 13] ipath - improve sparse annotation
X-Mercurial-Node: f23abcaaea8479fdfdc67081b526d1cdfafb0113
Message-Id: <f23abcaaea8479fdfdc6.1145913787@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1145913776@eng-12.pathscale.com>
Date: Mon, 24 Apr 2006 14:23:07 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 36447eb1f256 -r f23abcaaea84 drivers/infiniband/hw/ipath/ips_common.h
--- a/drivers/infiniband/hw/ipath/ips_common.h	Mon Apr 24 14:21:04 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ips_common.h	Mon Apr 24 14:21:04 2006 -0700
@@ -95,7 +95,7 @@ struct ether_header {
 	__u8 seq_num;
 	__le32 len;
 	/* MUST be of word size due to PIO write requirements */
-	__u32 csum;
+	__le32 csum;
 	__le16 csum_offset;
 	__le16 flags;
 	__u16 first_2_bytes;
