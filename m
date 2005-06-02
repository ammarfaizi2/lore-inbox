Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVFBAnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVFBAnK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 20:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVFBAnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 20:43:10 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:16065 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261260AbVFBAnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 20:43:03 -0400
X-Comment: AT&T Maillennium special handling code - c
From: Parag Warudkar <kernel-stuff@comcast.net>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Date: Wed, 1 Jun 2005 20:37:52 -0400
User-Agent: KMail/1.8
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
References: <1117667378.6801.80.camel@cog.beaverton.ibm.com> <1117667536.17474.0.camel@cog.beaverton.ibm.com> <1117667631.17474.3.camel@cog.beaverton.ibm.com>
In-Reply-To: <1117667631.17474.3.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hTlnCjo686AiqUN"
Message-Id: <200506012037.53226.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_hTlnCjo686AiqUN
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 01 June 2005 19:13, john stultz wrote:
> This patch converts the x86-64 arch to use the new timeofday
> infrastructure. It applies on top of my timeofday-core_B1 patch.

This one fails to apply - time.c HUNK #1 gets rejected. (Attached)

Parag

--Boundary-00=_hTlnCjo686AiqUN
Content-Type: text/x-csrc;
  charset="utf-8";
  name="time.c.rej"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="time.c.rej"

***************
*** 26,35 ****
  #include <linux/sysdev.h>
  #include <linux/bcd.h>
  #include <linux/kallsyms.h>
- #include <linux/acpi.h>
- #ifdef CONFIG_ACPI
- #include <acpi/achware.h>	/* for PM timer frequency */
- #endif
  #include <asm/8253pit.h>
  #include <asm/pgtable.h>
  #include <asm/vsyscall.h>
--- 26,31 ----
  #include <linux/sysdev.h>
  #include <linux/bcd.h>
  #include <linux/kallsyms.h>
  #include <asm/8253pit.h>
  #include <asm/pgtable.h>
  #include <asm/vsyscall.h>

--Boundary-00=_hTlnCjo686AiqUN--
