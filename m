Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751516AbVLFIOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbVLFIOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 03:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbVLFIOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 03:14:46 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:58359 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751516AbVLFIOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 03:14:45 -0500
From: Len Brown <len.brown@intel.com>
Organization: Intel Open Source Technology Center
To: torvalds@osdl.org
Subject: git pull on Linux/ACPI release tree
Date: Tue, 6 Dec 2005 03:17:50 -0500
User-Agent: KMail/1.8.2
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <200512010305.43469.len.brown@intel.com>
In-Reply-To: <200512010305.43469.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512060317.53925.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

This will update the file shown below.

thanks!

-Len

 drivers/acpi/processor_idle.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

through these commits:

David Shaohua Li:
      [ACPI] correct earlier SMP deep C-states on HT patch

with this log:

commit 927fe18397b3b1194a5b26b1d388d97e391e5fd2
Merge: e4f5c82a92c2a546a16af1614114eec19120e40a 
1e483969930a82e16767884449f3a121a817ef00
Author: Len Brown <len.brown@intel.com>
Date:   Mon Dec 5 17:08:40 2005 -0500

    Pull 5165 into release branch

commit 1e483969930a82e16767884449f3a121a817ef00
Author: David Shaohua Li <shaohua.li@intel.com>
Date:   Thu Dec 1 17:00:00 2005 -0500

    [ACPI] correct earlier SMP deep C-states on HT patch
    
    http://bugzilla.kernel.org/show_bug.cgi?id=5165
    
    Change polarity of test for PLVL2_UP flag.
    Skip promotion/demotion code when not needed.
    
    Signed-off-by: Shaohua Li <shaohua.li@intel.com>
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

