Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbTHVG3w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 02:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbTHVG3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 02:29:52 -0400
Received: from smtp.mailix.net ([216.148.213.132]:9329 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S263040AbTHVG3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 02:29:50 -0400
Date: Fri, 22 Aug 2003 08:29:45 +0200
From: Alex Riesen <fork0@users.sf.net>
To: andrew.grover@intel.com
Cc: acpi-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test3+bk: ACPI does not switch off the computer
Message-ID: <20030822062945.GA1128@steel.home>
Reply-To: Alex Riesen <fork0@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually it started happening from -test3.
The last I see on screen is "Power down." and the system is halted.
CAD reboots it.

-alex

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI_HT=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

