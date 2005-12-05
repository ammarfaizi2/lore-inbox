Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVLEM3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVLEM3k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 07:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVLEM3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 07:29:40 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:16291 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932394AbVLEM3j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 07:29:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WHaCUo5D/EpVXuJ0KGsErMqtcelmxrMTnTyEPwCYryovssWRbpuhmrjUnUDhNfh/uBlu5N7sADFM3kt47b1b/rPDyHfR+4nY1Cl8f6NHtlewZ2yLhRQcBAm20pNUJtWOSvD/5ArBuZQXyleBxDswMdJ8pNPMLhHOvJNf27KzqC0=
Message-ID: <5022ae630512050429i461fded9h728d3cbb6ccf49aa@mail.gmail.com>
Date: Mon, 5 Dec 2005 14:29:38 +0200
From: Raiden Anderson <d3vic3@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] include/asm-i386/acpi.h put missing header cousing build error
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a missing header in that file cousing a build failure

--- a/include/asm-i386/acpi.h
+++ b/include/asm-i386/acpi.h
@@ -29,7 +29,7 @@
 #ifdef __KERNEL__

 #include <acpi/pdc_intel.h>
-
+#include <asm/processor.h>
 #include <asm/system.h>                /* defines cmpxchg */

 #define COMPILER_DEPENDENT_INT64   long long
