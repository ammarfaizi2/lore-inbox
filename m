Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbUKHERR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbUKHERR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 23:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUKHERR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 23:17:17 -0500
Received: from fmr06.intel.com ([134.134.136.7]:30367 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261747AbUKHERE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 23:17:04 -0500
Subject: [PATCH/RFC 0/4]Bind physical devices with ACPI devices
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Greg <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>
Content-Type: text/plain
Message-Id: <1099887066.1750.241.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 08 Nov 2004 12:11:06 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
ACPI provides many functionalities for physical devices. Such as for
suspend/resume, ACPI can tell us correct devices D-state for S3. There
are tons of devices enhancement for both realtime and boot time from
ACPI. To utilize ACPI, physical devices like PCI devices must know its
partner. The patches try to do this. After this is done, we can enhance
many features, such as improve suspend/resume.
These patches are against 2.6.10-rc1, please give your comments.

Thanks,
Shaohua

