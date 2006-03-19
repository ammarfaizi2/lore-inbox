Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWCSBKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWCSBKI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 20:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWCSBKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 20:10:08 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:62856 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751180AbWCSBKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 20:10:06 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc6-mm2 uninitialized online_policy_cpus.bits[0]
Date: Sun, 19 Mar 2006 12:09:54 +1100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060318044056.350a2931.akpm@osdl.org>
In-Reply-To: <20060318044056.350a2931.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603191209.54946.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wonder if this is related to rc6's oops?
gcc 4.0.3

  CC [M]  arch/i386/kernel/cpu/cpufreq/speedstep-centrino.o
arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c: In function 
'centrino_target':
include/linux/bitmap.h:170: warning: 'online_policy_cpus.bits[0]' is used 
uninitialized in this function
  CC [M]  arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.o
arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c: In function 
'acpi_cpufreq_target':
include/linux/bitmap.h:170: warning: 'online_policy_cpus.bits[0]' is used 
uninitialized in this function

config here:
http://ck.kolivas.org/crap/lapconfig

Con
