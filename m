Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268243AbTBNIWP>; Fri, 14 Feb 2003 03:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268240AbTBNIWP>; Fri, 14 Feb 2003 03:22:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65064 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S268243AbTBNIWN>; Fri, 14 Feb 2003 03:22:13 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: suparna@in.ibm.com, fastboot@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [KEXEC][PATCH] Modified (smaller) x86 kexec hwfixes patch
References: <20030213161014.A14361@in.ibm.com>
	<m1heb8w737.fsf@frodo.biederman.org> <20030214085915.A1466@in.ibm.com>
	<51710000.1045205264@[10.10.2.4]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Feb 2003 01:32:08 -0700
In-Reply-To: <51710000.1045205264@[10.10.2.4]>
Message-ID: <m165rn8dpz.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> Running on my 4-way P3 test box (just SMP, not NUMA) kexec_test
> prints this:
> 
> Synchronizing SCSI caches: 
> Shutting down devices
> Starting new kernel
> kexec_test 1.8 starting...
> eax: 0E1FB007 ebx: 0000011C ecx: 00000000 edx: 00000000
> esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
> idt: 00000000 C0000000
> gdt: 0000006F 000000A0
> Switching descriptors.
> Descriptors changed.
> Legacy pic setup.
> In real mode.
> 
> Without that I just get:
> 
> Synchronizing SCSI caches: 
> Shutting down devices
> Starting new kernel
> 
> Can someone interpret?

Besides the fact that you cannot make BIOS calls, and kexec is working
there is not much to say.  You cannot kexec another kernel?

Eric

