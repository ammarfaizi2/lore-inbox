Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVFBXNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVFBXNH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 19:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVFBXNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 19:13:06 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:44929 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261439AbVFBXKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 19:10:21 -0400
X-Comment: AT&T Maillennium special handling code - c
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Date: Thu, 2 Jun 2005 19:05:06 -0400
User-Agent: KMail/1.8
Cc: john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <20050602183904.GC2636@us.ibm.com>
In-Reply-To: <20050602183904.GC2636@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506021905.08274.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 June 2005 14:39, Nishanth Aravamudan wrote:
> Which timesource is being used?
>
> cat /sys/devices/system/timesource/timesource0/timesource

tux-gentoo parag # cat /sys/devices/system/timesource/timesource0/timesource
jiffies tsc tsc-interp *acpi_pm

I am not attaching the dmesg output as it is fairly big and the only relevant 
line seems to be

Jun  1 20:56:18 tux-gentoo [   20.302560] Time: acpi_pm timesource has been 
installed.

Parag

-- 
Q: Would you like to see the WINE list?
A: What's on it, anything expensive?
Q: No, just Solitaire and MineSweeper for now, but the WINE is free.
	-- Kevin M. Bealer, about the WINdows Emulator
