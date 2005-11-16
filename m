Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbVKPRRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbVKPRRa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbVKPRRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:17:30 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:52125 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751486AbVKPRR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:17:29 -0500
Date: Wed, 16 Nov 2005 15:17:33 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] - Removes unused data from pl2303 driver.
Message-Id: <20051116151733.36358920.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

 This patch removes unused data from pl2303 driver.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 drivers/usb/serial/pl2303.c |    4 ----
 1 files changed, 4 deletions(-)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -39,11 +39,7 @@
 static int debug;
 
 #define PL2303_CLOSING_WAIT	(30*HZ)
-
 #define PL2303_BUF_SIZE		1024
-#define PL2303_TMP_BUF_SIZE	1024
-
-static DECLARE_MUTEX(pl2303_tmp_buf_sem);
 
 struct pl2303_buf {
 	unsigned int	buf_size;


-- 
Luiz Fernando N. Capitulino
