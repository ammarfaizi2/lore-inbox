Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWFBRou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWFBRou (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 13:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWFBRou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 13:44:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:48740 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751349AbWFBRot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 13:44:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OnFqIArigusOvzehViKfGGbQ+64Ki+ENg2+1R6BK4bOJlBj3jMlbf8nv5x3URAN/F0W2E8F5d0zx0y2fHub34zvClYoe3ELfKjprfaEw2244u4+htA57NbiFrYWmwDTurLn61cPMSn8AGpifzcPqM3E4EY8iNQaSsBV2AJ0p0lA=
Message-ID: <4480790D.8070105@gmail.com>
Date: Fri, 02 Jun 2006 20:44:45 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: [patch] input: fix function name in a comment
References: <20060530105705.157014000@gmail.com>	<20060530110131.136225000@gmail.com>	<20060530222122.069da389.rdunlap@xenotime.net>	<447F3AE4.6010206@gmail.com>	<20060601125256.de2897f4.rdunlap@xenotime.net>	<447F47FD.2050705@gmail.com>	<20060601130923.38f83fb6.rdunlap@xenotime.net>	<20060601204716.GA6847@delta.onse.fi> <20060601143356.f5b8d4f5.rdunlap@xenotime.net>
In-Reply-To: <20060601143356.f5b8d4f5.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix function name in a comment in drivers/usb/input/hid-pidff.c.

---

This is to be applied after my previous patch "input: fix comments and
blank lines in new ff code" (Thu, 1 Jun 2006 23:47:16 +0300).

 drivers/usb/input/hid-pidff.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.17-rc4-git12/drivers/usb/input/hid-pidff.c
===================================================================
--- linux-2.6.17-rc4-git12.orig/drivers/usb/input/hid-pidff.c	2006-06-01 23:24:47.000000000 +0300
+++ linux-2.6.17-rc4-git12/drivers/usb/input/hid-pidff.c	2006-06-02 20:31:31.000000000 +0300
@@ -926,7 +926,7 @@ static int pidff_reports_ok(struct input
 }
 
 /*
- * pidff_find_logical_field - find a field with a specific logical usage
+ * pidff_find_special_field - find a field with a specific logical usage
  * @report: the report from where to find
  * @usage: the wanted usage
  * @enforce_min: logical_minimum should be 1, otherwise return NULL


