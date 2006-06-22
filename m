Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161182AbWFVSx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161182AbWFVSx4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161183AbWFVSx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:53:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:21028 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161182AbWFVSxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:53:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=HFNznVEKTOeoYkrSyxE+1v2yaBqxJX95WlUt5AHllxDUtt5H+ZDzmTg9xmgYO6R05R3z88QKP4OlShRMnOz3zPBIJW3AHo1TIGwxxJT2GAZ3ndJN5Fn+a/fDJb+/NWSAU7CAcO5BFG+pGAh1rHlxE0Em/35y5YOoSKgTu8xr+oo=
Message-ID: <449AE741.1020602@gmail.com>
Date: Thu, 22 Jun 2006 12:53:53 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [ patch -mm1 07/11 ] gpio-patchset-fixups: no weird comment placement
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff.13-fix-weird-comment

put comment in body, like everyone else.

Signed-off-by:   Jim Cromie <jim.cromie@gmail.com>

---

diff -ruNp -X dontdiff -X exclude-diffs 17-mm-pre0/drivers/char/pc8736x_gpio.c 13/drivers/char/pc8736x_gpio.c
--- 17-mm-pre0/drivers/char/pc8736x_gpio.c	2006-06-20 20:42:39.000000000 -0600
+++ 13/drivers/char/pc8736x_gpio.c	2006-06-21 10:31:31.000000000 -0600
@@ -89,8 +89,8 @@ static inline int superio_inb(int addr)
 }
 
 static int pc8736x_superio_present(void)
-     /* try the 2 possible values, read a hardware reg to verify */
 {
+	/* try the 2 possible values, read a hardware reg to verify */
 	superio_cmd = SIO_BASE1;
 	if (superio_inb(SIO_SID) == SIO_SID_VALUE)
 		return superio_cmd;


