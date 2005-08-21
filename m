Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVHUVfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVHUVfk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVHUVfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:35:40 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:41676 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751139AbVHUVfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:35:39 -0400
Message-ID: <4308C428.5070302@m1k.net>
Date: Sun, 21 Aug 2005 14:12:56 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH] fix documentation for dvb-bt8xx Kconfig description change
References: <200508180445.j7I4jiRn030994@shell0.pdx.osdl.net>
In-Reply-To: <200508180445.j7I4jiRn030994@shell0.pdx.osdl.net>
Content-Type: multipart/mixed;
 boundary="------------080402000306000708070901"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080402000306000708070901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

akpm@osdl.org wrote:

>DVB: Clarify description text for dvb-bt8xx in Kconfig
>
>-	tristate "Nebula/Pinnacle PCTV/Twinhan PCI cards"
>+	tristate "BT8xx based PCI cards"
>
I forgot to update the documentation with this change... Please apply 
this to -mm, and (if possible) fold it into 
dvb-clarify-description-text-for-dvb-bt8xx-in-kconfig.patch

This patch updates bt8xx documentation with the newer Kconfig 
description of dvb-bt8xx.
"Nebula/Pinnacle PCTV/Twinhan PCI cards" --> "BT8xx based PCI cards"

Signed-off-by: Michael Krufky <mkrufky@m1k.net>



--------------080402000306000708070901
Content-Type: text/plain;
 name="doc-dvb-bt8xx-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="doc-dvb-bt8xx-fix.patch"

 linux/Documentation/dvb/bt8xx.txt |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -u linux-2.6.13/Documentation/dvb/bt8xx.txt linux/Documentation/dvb/bt8xx.txt
--- linux-2.6.13/Documentation/dvb/bt8xx.txt	2005-08-20 10:57:24.000000000 +0000
+++ linux/Documentation/dvb/bt8xx.txt	2005-08-21 13:54:27.000000000 +0000
@@ -16,7 +16,7 @@
 "Device drivers" => "Multimedia devices"
  => "Video For Linux" => "BT848 Video For Linux"
 "Device drivers" => "Multimedia devices" => "Digital Video Broadcasting Devices"
- => "DVB for Linux" "DVB Core Support" "Nebula/Pinnacle PCTV/TwinHan PCI Cards"
+ => "DVB for Linux" "DVB Core Support" "BT8xx based PCI cards"
 
 3) Loading Modules, described by two approaches
 ===============================================

--------------080402000306000708070901--
