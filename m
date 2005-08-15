Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbVHOUaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbVHOUaH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 16:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbVHOUaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 16:30:07 -0400
Received: from zorn.worldpath.net ([206.152.180.10]:12797 "EHLO
	unix.worldpath.net") by vger.kernel.org with ESMTP id S964913AbVHOUaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 16:30:06 -0400
Subject: [GIT PATCH] ACPI patch for 2.6.13-rc6
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <1123175479.13136.21.camel@toshiba>
References: <1122702560.26850.9.camel@toshiba>
	 <1123110985.13136.12.camel@toshiba>  <1123175479.13136.21.camel@toshiba>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 16:35:59 -0400
Message-Id: <1124138159.17245.4.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from: 

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/to-linus.git

This patch allows the platform-specific drivers, such as toshiba_acpi
and asus_acpi to run w/o any cmdline flags -- like they did in 2.6.12.

thanks,
-Len

ps. The latest ACPI patch, including this and more lives here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.12
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.13

This will update the following files:

 Documentation/acpi-hotkey.txt       |    3 +++
 Documentation/kernel-parameters.txt |    5 +++++
 drivers/acpi/osl.c                  |    6 +++---
 3 files changed, 11 insertions(+), 3 deletions(-)

through these commits:

--------------------------
commit 30e332f3307e9f7718490a706e5ce99f0d3a7b26
tree 39054cfaf058a369f2b75bd89265e83522c02b49
parent d4ab025b73a2d10548e17765eb76f3b7351dc611
author Luming Yu <luming.yu@intel.com> 1123821060 -0400
committer Len Brown <len.brown@intel.com> 1124135218 -0400

[ACPI] re-enable platform-specific hotkey drivers by default

When both platform-specific and generic drivers exist,
enable generic over-ride with "acpi_generic_hotkey".

http://bugzilla.kernel.org/show_bug.cgi?id=4953

Signed-off-by: Luming Yu <luming.yu@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>

--------------------------


