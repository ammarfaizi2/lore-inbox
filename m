Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWIYVxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWIYVxz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWIYVxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:53:55 -0400
Received: from mail.polish-dvd.com ([69.222.0.225]:52683 "HELO
	mail.webhostingstar.com") by vger.kernel.org with SMTP
	id S1751492AbWIYVxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:53:55 -0400
Message-ID: <20060925162856.th72i3dtmoqo0gk4@69.222.0.225>
Date: Mon, 25 Sep 2006 16:28:56 -0500
From: art@usfltd.com
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: Re: New section mismatch warning on latest linux-2.6 git tree
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.1.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on 2.6.18-git4 SMP x86_64

[xxx@localhost linux-2.6.18]$ make -j 4
   CHK     include/linux/version.h
   CHK     include/linux/utsrelease.h
   CHK     include/linux/compile.h
   MODPOST vmlinux
   Building modules, stage 2.
Kernel: arch/x86_64/boot/bzImage is ready  (#4)
   MODPOST 1150 modules
WARNING: arch/x86_64/kernel/cpufreq/acpi-cpufreq.o - Section mismatch:  
reference to .init.data: from .text between 'acpi_cpufreq_cpu_init'  
(at offset 0x3b9) and 'acpi_cpufreq_target'
WARNING: drivers/atm/he.o - Section mismatch: reference to .init.text:  
from .text between 'he_start' (at offset 0x211e) and 'he_service_tbrq'


xboom
