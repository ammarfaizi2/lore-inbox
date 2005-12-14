Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbVLNFhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbVLNFhB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 00:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbVLNFhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 00:37:01 -0500
Received: from fmr24.intel.com ([143.183.121.16]:55520 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751371AbVLNFhA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 00:37:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: stall during boot on x86-64.
Date: Tue, 13 Dec 2005 21:36:43 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB60069E67D8@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: stall during boot on x86-64.
Thread-Index: AcYAXgD+l88zVi+KRneA6vccp6TYWQAEinYA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Dave Jones" <davej@redhat.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Dec 2005 05:36:45.0057 (UTC) FILETIME=[5EA0C710:01C60070]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Dave Jones
>Sent: Tuesday, December 13, 2005 7:22 PM
>To: Linux Kernel
>Subject: stall during boot on x86-64.
>
>When I boot my EM64T, I get a slight noticable pause
>really early on in boot.  Booting with 'time'
>shows an interesting artifact.
>
>Kernel command line: ro root=/dev/VolGroup00/LogVol00 
>console=ttyS0,38400 console=tty0 time
>kernel profiling enabled (shift: 1)
>[    0.000000] Initializing CPU#0
>[    0.000000] PID hash table entries: 4096 (order: 12, 131072 bytes)
>[    0.000000] time.c: Using 14.318180 MHz HPET timer.
>[    0.000000] time.c: Detected 2793.081 MHz processor.
>[   27.449661] Console: colour VGA+ 80x25
>[   28.484309] Dentry cache hash table entries: 131072 (order: 
>8, 1048576 bytes)
>[   28.506519] Inode-cache hash table entries: 65536 (order: 
>7, 524288 bytes)
>[   28.539543] Memory: 1014240k/1047080k available (2490k 
>kernel code, 32456k reserved, 1664k data, 236k init)
>
>Note the jump in the time value..

May be this is just the origin of time as far as kernel is concerned.
No?

Thanks,
Venki
