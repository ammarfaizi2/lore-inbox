Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267257AbSKVBGi>; Thu, 21 Nov 2002 20:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267256AbSKVBGi>; Thu, 21 Nov 2002 20:06:38 -0500
Received: from fmr02.intel.com ([192.55.52.25]:49648 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267257AbSKVBGh>; Thu, 21 Nov 2002 20:06:37 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A535@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, "'Stelian Pop'" <stelian.pop@fr.alcove.com>
Subject: [BK PATCH] Allow others to use ACPI EC interface
Date: Thu, 21 Nov 2002 17:13:37 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a

	bk pull http://linux-acpi.bkbits.net/linux-acpi

Stelian's sonypi driver will make use of these in the near future.

Regards -- Andy

This will update the following files:

 drivers/acpi/acpi_ksyms.c |    9 +
 drivers/acpi/ec.c         |  165 ++++++++++++++++++++--------------
 include/linux/acpi.h      |    6 +
 3 files changed, 115 insertions(+), 65 deletions(-)

through these ChangeSets:

<agrover@groveronline.com> (02/11/20 1.842.1.56)
   ACPI: Add ec_read and ec_write external functions
     Other ec.c cleanups, too
