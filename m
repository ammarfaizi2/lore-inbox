Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVAZXNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVAZXNk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbVAZXMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:12:43 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:37854 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262441AbVAZRZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:25:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type;
        b=jpgO7D5X8Nf9xYxMKGM6S/+C/EGH9QZWLY5uXifBEmU2w6DjRPM0GLrmxfp+LE5EUhS3EwhR9sto4dc1Mf5H9HqbBV9A3U82aJjDW9RQgJ1NzJX//Iv1W1xBgyDNtKhpcXwOj12d/5FFJ3nYQIT1XQmAHrJTtkfAbRiPLCXlZmg=
Message-ID: <41F7D289.2010001@gmail.com>
Date: Wed, 26 Jan 2005 18:25:29 +0100
From: Mikkel Krautz <krautz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: greg@kroah.com, roms@lpg.ticalc.org, jb@technologeek.org
Subject: [PATCH 1/3] TIGLUSB Cleanups
Content-Type: multipart/mixed;
 boundary="------------080109070600010401020605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080109070600010401020605
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This removes the tiusb boot-parameter from kernel-parameters.txt.

--------------080109070600010401020605
Content-Type: text/x-patch;
 name="remove_silverlink_bootparam.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove_silverlink_bootparam.patch"

Signed-off-by: Mikkel Krautz <krautz@gmail.com>
---

 kernel-parameters.txt |    3 ---
 1 files changed, 3 deletions(-)
 
--- clean/Documentation/kernel-parameters.txt
+++ dirty/Documentation/kernel-parameters.txt
@@ -1356,9 +1356,6 @@
 	tipar.delay=	[HW,PPT]
 			Set inter-bit delay in microseconds (default 10).
 
-	tiusb=		[HW,USB] Texas Instruments' USB GraphLink (aka SilverLink)
-			Format: <timeout>
- 
 	tmc8xx=		[HW,SCSI]
 			See header of drivers/scsi/seagate.c.
 

--------------080109070600010401020605--
