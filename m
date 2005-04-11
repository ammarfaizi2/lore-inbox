Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVDKJpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVDKJpj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 05:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVDKJpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 05:45:39 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:232 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261749AbVDKJpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 05:45:18 -0400
Message-ID: <425A481A.7020801@anagramm.de>
Date: Mon, 11 Apr 2005 11:49:14 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
Organization: Anagramm GmbH
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: de-de, en-us, en, ko
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] I2C rtc8564.c remove duplicate include (whitespace fixed)
References: <425125EC.6080201@anagramm.de> <20050409131643.4269911a.khali@linux-fr.org>
In-Reply-To: <20050409131643.4269911a.khali@linux-fr.org>
Content-Type: multipart/mixed;
 boundary="------------030706000608050006090402"
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:224ad0fd4f2efe95e6ec4f0a3ca8a73c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030706000608050006090402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

[PATCH] I2C rtc8564.c remove duplicate include

Trivial fix: removes duplicate include line.
Patch applies to: 2.6.11.x

(This is my very first patch to the linux-kernel, so let me
start with small things first...)

Signed-off-by: Clemens Koller <clemens.koller@anagramm.de>
---

--------------030706000608050006090402
Content-Type: text/x-diff;
 name="rtc8564.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtc8564.diff"

diff -Nur --exclude-from=dontdiff-osdl linux-2.6.11.6-clean/drivers/i2c/chips/rtc8564.c linux-2.6.11.6/drivers/i2c/chips/rtc8564.c
--- linux-2.6.11.6-clean/drivers/i2c/chips/rtc8564.c	2005-03-26 04:28:14.000000000 +0100
+++ linux-2.6.11.6/drivers/i2c/chips/rtc8564.c	2005-04-04 12:37:05.000000000 +0200
@@ -19,7 +19,6 @@
 #include <linux/string.h>
 #include <linux/rtc.h>		/* get the user-level API */
 #include <linux/init.h>
-#include <linux/init.h>
 
 #include "rtc8564.h"
 

--------------030706000608050006090402--
