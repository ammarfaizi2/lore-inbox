Return-Path: <linux-kernel-owner+w=401wt.eu-S1422714AbWLPWkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422714AbWLPWkz (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 17:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422712AbWLPWkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 17:40:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:34787 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422708AbWLPWky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 17:40:54 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,179,1165219200"; 
   d="scan'208"; a="178368956:sNHT23159682"
Date: Sat, 16 Dec 2006 14:40:42 -0800
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 0/2] more patches for removable drive bay
Message-Id: <20061216144042.a994bf91.kristen.c.accardi@intel.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,
Here's a set of patches for changing the removable drive bay driver
(drivers/acpi/bay) from using the old proc interface to using a sysfs
interface instead.  I made the bay driver a platform driver, and 
so it's entries will now be located in /sys/devices/platform/bay.X.
There are still 2 entries - one for checking whether the bay is
present (present) that is read only, and one that is write only for
ejecting the bay (eject).  Let me know if you would prefer me to fold
these into the original bay driver patch.

Thanks,
Kristen
--
