Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSILIFw>; Thu, 12 Sep 2002 04:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSILIFw>; Thu, 12 Sep 2002 04:05:52 -0400
Received: from firewall.osb.hu ([193.224.234.1]:30226 "EHLO firewall")
	by vger.kernel.org with ESMTP id <S311885AbSILIFv>;
	Thu, 12 Sep 2002 04:05:51 -0400
Date: Thu, 12 Sep 2002 10:04:37 +0200 (CEST)
From: Soos Peter <sp@osb.hu>
To: linux-kernel@vger.kernel.org
Subject: APM & ACPI detect
Message-ID: <Pine.LNX.4.44.0209120959510.3671-100000@sppc.intranet.osb.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Are there any "official way" to detect that APM or ACPI is active?

With APM I try it and it works:

#ifdef CONFIG_APM
#include <linux/apm_bios.h>
#endif

...

#ifdef CONFIG_APM
if (apm_info.disabled >= 0) {
                printk(KERN_NOTICE "Real APM support is present.\n");
}
#endif

Are there any similar for ACPI?

Thanks,
Peter

