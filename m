Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbUEWJZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUEWJZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 05:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUEWJZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 05:25:57 -0400
Received: from mail.gmx.de ([213.165.64.20]:49835 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261745AbUEWJZx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 05:25:53 -0400
X-Authenticated: #1269185
From: Manuel Kasten <kasten.m@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [speedste-centrino] couldn't enable Enhanced SpeedStep
Date: Sun, 23 May 2004 11:26:11 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405231126.11815.kasten.m@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

speedstep-centrino won't load on my laptop running 2.6.6 :

$ cat /var/log/dmesg | grep speedstep
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1500MHz": max
frequency: 1500000kHz
speedstep-centrino: couldn't enable Enhanced SpeedStep

Can anybody explain what's going on?

Thanks,
        Manuel Kasten




######   .config    ######
#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_PROC_INTF=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_24_API=y
CONFIG_CPU_FREQ_TABLE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
# CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI is not set
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_LONGRUN is not set
# CONFIG_X86_LONGHAUL is not set
