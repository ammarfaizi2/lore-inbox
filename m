Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUAOUEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 15:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUAOUEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 15:04:20 -0500
Received: from palrel11.hp.com ([156.153.255.246]:54978 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263491AbUAOUER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 15:04:17 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16390.62011.1043.575769@napali.hpl.hp.com>
Date: Thu, 15 Jan 2004 12:04:10 -0800
To: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Cc: akpm@osdl.org, davidm@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Matt_Domsch@dell.com,
       matthew.e.tolentino@intel.com
Subject: Re: [patch] efivars update for 2.6.1
In-Reply-To: <200401151936.i0FJaopB001880@snoqualmie.dp.intel.com>
References: <200401151936.i0FJaopB001880@snoqualmie.dp.intel.com>
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, how about adding the URL to the updated efibootmgr to the
help-text for EFI_VARS?

	--david

+#
+# EFI Driver Configuration
+#
+
+menu "EFI driver support"
+depends on EFI
+
+config EFI_VARS
+	tristate "EFI Variable Support via sysfs"
+	depends on EFI
+	default n
+	---help---
+	  If you say Y here, you are able to get EFI (Extensible Firmware
+	  Interface) variable information via sysfs.  You may read,
+	  write, create, and destroy EFI variables through this interface.
+
+
+endmenu
