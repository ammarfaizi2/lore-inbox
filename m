Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbTJ1WNx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 17:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbTJ1WNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 17:13:53 -0500
Received: from fmr03.intel.com ([143.183.121.5]:15260 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S261762AbTJ1WNu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 17:13:50 -0500
Subject: [BK PATCH] ACPI x86_64 build fix for 2.4
From: Len Brown <len.brown@intel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1067379189.2637.79.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Oct 2003 17:13:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, please do a 

	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.4.23

	Thanks to Jeff Garzik @ Red Hat for helping me see the errors
	of my ways, and to Andy Kleen @ SuSE for helping me fix them --
	by providing an x86_64 cross build env.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.23-pre8/acpi-20031002-2.4.23-pre8.diff.gz

This will update the following files:

 arch/x86_64/kernel/acpi.c |   56 +++++++++++++++++++++++++++++++++-
 1 files changed, 55 insertions(+), 1 deletion(-)

through these ChangeSets:

<len.brown@intel.com> (03/10/28 1.1063.44.32)
   [ACPI] fix x86_64 build (Jeff Garzik)




