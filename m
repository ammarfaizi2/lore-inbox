Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290273AbSAXG3t>; Thu, 24 Jan 2002 01:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290270AbSAXG3j>; Thu, 24 Jan 2002 01:29:39 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:24266 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S290273AbSAXG30>; Thu, 24 Jan 2002 01:29:26 -0500
Date: Thu, 24 Jan 2002 08:25:05 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: mirian@cosmic.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: network hangs, NETDEV WATCHDOG messages, Dual AMD Duron, APIC
Message-ID: <Pine.LNX.4.44.0201240823470.28541-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you tested with another NIC? I've witnessed a problem similar to 
yours recently (specific machines could login to a Samba server and i 
could ssh out to/from the server but file copies from Samba failed after 
copying 20-30 files. Please test with another NIC (another Tulip maybe?) 
so that we can determine wether its a hardware/kernel issue.

Also consider that Duron SMP is not a supported configuration, and 
therefore CPU/PIC based issues like APIC problems aren't going to get you 
far with some of the kernel hackers. Incidentally, what are the cpuids of 
your Durons? 

Regards,
	Zwane Mwaikambo

