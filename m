Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267921AbUHaLcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267921AbUHaLcP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 07:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267934AbUHaLcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 07:32:15 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:32143 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267921AbUHaLcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 07:32:13 -0400
From: Stuart Young <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc1-mm2 : Recursive Kconfig dependency
Date: Tue, 31 Aug 2004 21:32:20 +1000
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408312132.20767.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just noticed this when running either 'make oldconfig' or 'make menuconfig'.


scripts/kconfig/conf -o arch/i386/Kconfig
Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_AC
Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_PROCESSOR 
X86_POWERNOW_K7_ACPI
Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_PROCESSOR 
X86_POWERNOW_K8_ACPI
Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_EC
Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_PROCESSOR 
X86_SPEEDSTEP_CENTRINO_ACPI
Warning! Found recursive dependency: DRM_I830 DRM_I915 DRM_I830
#
# using defaults found in .config
#

-- 
 Stuart Young (aka Cef)
 cef-lkml@optusnet.com.au is for LKML and related email only
