Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268226AbTBNGiB>; Fri, 14 Feb 2003 01:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268229AbTBNGiB>; Fri, 14 Feb 2003 01:38:01 -0500
Received: from franka.aracnet.com ([216.99.193.44]:58268 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268226AbTBNGiA>; Fri, 14 Feb 2003 01:38:00 -0500
Date: Thu, 13 Feb 2003 22:47:44 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: suparna@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>
cc: fastboot@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [KEXEC][PATCH] Modified (smaller) x86 kexec hwfixes patch
Message-ID: <51710000.1045205264@[10.10.2.4]>
In-Reply-To: <20030214085915.A1466@in.ibm.com>
References: <20030213161014.A14361@in.ibm.com>
 <m1heb8w737.fsf@frodo.biederman.org> <20030214085915.A1466@in.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running on my 4-way P3 test box (just SMP, not NUMA) kexec_test
prints this:

Synchronizing SCSI caches: 
Shutting down devices
Starting new kernel
kexec_test 1.8 starting...
eax: 0E1FB007 ebx: 0000011C ecx: 00000000 edx: 00000000
esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
idt: 00000000 C0000000
gdt: 0000006F 000000A0
Switching descriptors.
Descriptors changed.
Legacy pic setup.
In real mode.

Without that I just get:

Synchronizing SCSI caches: 
Shutting down devices
Starting new kernel

Can someone interpret?

