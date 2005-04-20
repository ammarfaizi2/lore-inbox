Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVDTEIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVDTEIP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 00:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVDTEIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 00:08:15 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:37124 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S261321AbVDTEIM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 00:08:12 -0400
Date: Wed, 20 Apr 2005 13:10:34 +0900 (JST)
Message-Id: <20050420.131034.42261841.yoshfuji@linux-ipv6.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] USB: compilation failure on usb/image/microtek.c
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

maybe typo?

Signed-off-by: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>

--- a/drivers/usb/image/microtek.c
+++ b/drivers/usb/image/microtek.c
@@ -335,7 +335,7 @@ static int mts_scsi_abort (Scsi_Cmnd *sr
 
 	mts_urb_abort(desc);
 
-	return FAILURE;
+	return FAILED;
 }
 
 static int mts_scsi_host_reset (Scsi_Cmnd *srb)

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
Homepage: http://www.yoshifuji.org/~hideaki/
GPG FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
