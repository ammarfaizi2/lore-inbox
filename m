Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbVAZQOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVAZQOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVAZQOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:14:22 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:31153 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262341AbVAZQOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:14:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=KIV4MnicY+QOtH23ieNUogbg3TQ6On4fSW3DY93GCudtdgTn3c7nEvLmh4DmgAH0slRThOj8Gx+PaQ+tL5neaVLUjT8gAnPLenZ7ihi4c24bZJuRHKizVElhTxbinf/OARBMOj/+ZC93vKPROm/M9EgZMDCq02K822oVYJ7NurQ=
Message-ID: <41F7C01A.6020201@gmail.com>
Date: Wed, 26 Jan 2005 17:06:50 +0100
From: Mikkel Krautz <krautz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: greg@kroah.com, roms@lpg.ticalc.org, jb@technologeek.org
Subject: [PATCH 1/3] TIGLUSB Cleanups
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the tiusb boot-parameter from kernel-parameters.txt.


Signed-off-by: Mikkel Krautz <krautz@gmail.com>
---

 kernel-parameters.txt |    3 ---
 1 files changed, 3 deletions(-)
 
--- clean/Documentation/kernel-parameters.txt
+++ dirty/Documentation/kernel-parameters.txt
@@ -1356,9 +1356,6 @@
     tipar.delay=    [HW,PPT]
             Set inter-bit delay in microseconds (default 10).
 
-    tiusb=        [HW,USB] Texas Instruments' USB GraphLink (aka 
SilverLink)
-            Format: <timeout>
-
     tmc8xx=        [HW,SCSI]
             See header of drivers/scsi/seagate.c.
 

