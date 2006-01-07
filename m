Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752565AbWAGPym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbWAGPym (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 10:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752561AbWAGPym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 10:54:42 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:25321 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1752556AbWAGPyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 10:54:41 -0500
From: Len Brown <len.brown@intel.com>
Organization: Intel Open Source Technology Center
To: torvalds@osdl.org
Subject: git pull on Linux/ACPI release tree
Date: Sat, 7 Jan 2006 10:54:36 -0500
User-Agent: KMail/1.8.2
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <200512010305.43469.len.brown@intel.com> <200512060317.53925.len.brown@intel.com> <200512230042.17903.len.brown@intel.com>
In-Reply-To: <200512230042.17903.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601071054.37741.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull this batch of trivial patches from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

This will update the files shown below.

thanks!

-Len

 Documentation/DocBook/kernel-api.tmpl |    1 
 Documentation/kernel-parameters.txt   |    4 +++
 Documentation/pm.txt                  |    2 -
 MAINTAINERS                           |    2 -
 drivers/acpi/Kconfig                  |    2 -
 drivers/acpi/scan.c                   |   27 +++++++++++++---------
 drivers/acpi/tables.c                 |    4 +--
 7 files changed, 26 insertions(+), 16 deletions(-)

through these commits:

Borislav Petkov:
      [ACPI] remove Kconfig "default y" for laptop drivers

Len Brown:
      [ACPI] document processor.nocst parameter
      [ACPI] linux-acpi@vger.kernel.org replaces acpi-devel@lists.sourceforge.net
      [ACPI] reduce kernel size: move 5BK .bss to 2.5KB .init.data
      [ACPI] linux-acpi@vger.kernel.org replaces acpi-devel@lists.sourceforge.net

Randy Dunlap:
      [ACPI] fix kernel-doc warnings in acpi/scan.c

with this log:

commit f9a204e1de73a7007de66fb289e1d64a7665c9b4
Author: Borislav Petkov <bbpetkov@yahoo.de>
Date:   Fri Jan 6 01:31:00 2006 -0500

    [ACPI] remove Kconfig "default y" for laptop drivers
    
    Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit d758a8fa8ce0566947677f7e70bf70c57ad9445c
Author: Randy Dunlap <rdunlap@xenotime.net>
Date:   Fri Jan 6 01:31:00 2006 -0500

    [ACPI] fix kernel-doc warnings in acpi/scan.c
    
    Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 036d25f79ddfbc9878da24ef8e468a6d22caa605
Author: Len Brown <len.brown@intel.com>
Date:   Fri Jan 6 16:19:26 2006 -0500

    [ACPI] linux-acpi@vger.kernel.org replaces acpi-devel@lists.sourceforge.net
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 04348e69e7e78ad69a09b2e1157f628d6c764370
Author: Len Brown <len.brown@intel.com>
Date:   Fri Dec 30 02:44:59 2005 -0500

    [ACPI] reduce kernel size: move 5BK .bss to 2.5KB .init.data
    
    put __initdata on sdt_entry[], as it is accessed only by __init functions.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=1311
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 6968e50c2b53805219618203db3d98566dfa1fdd
Author: Len Brown <len.brown@intel.com>
Date:   Fri Dec 30 00:32:49 2005 -0500

    [ACPI] linux-acpi@vger.kernel.org replaces acpi-devel@lists.sourceforge.net
    
    Signed-off-by: Len Brown <len.brown@intel.com>

commit 41c0d8680f7f24e1abaaeeabc6723277b2e34b81
Author: Len Brown <len.brown@intel.com>
Date:   Wed Dec 28 12:43:51 2005 -0500

    [ACPI] document processor.nocst parameter
    
    Signed-off-by: Len Brown <len.brown@intel.com>

