Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbTLML5j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 06:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264947AbTLML5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 06:57:36 -0500
Received: from web9505.mail.yahoo.com ([216.136.129.135]:28938 "HELO
	web9505.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264584AbTLML5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 06:57:34 -0500
Message-ID: <20031213115733.79739.qmail@web9505.mail.yahoo.com>
Date: Sat, 13 Dec 2003 03:57:33 -0800 (PST)
From: neel vanan <neelvanan@yahoo.com>
Subject: acpi related error.....
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20031206054720.GN8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,
Currently i am working on RedHat9.0 kernel 2.4.20-8, i
am compiling kernel 2.6.0-test11 with NUMA and SMP
enabled. I had selected summit though i am having
non-summit box. When i am trying to make bzImage in
the last i get this message:
drivers/built-in.o(.init.text+0x30cf): In function
`acpi_parse_slit':
: undefined reference to `acpi_numa_slit_init'
drivers/built-in.o(.init.text+0x30f0): In function
`acpi_parse_processor_affinity':
: undefined reference to
`acpi_numa_processor_affinity_init'
drivers/built-in.o(.init.text+0x3110): In function
`acpi_parse_memory_affinity':
: undefined reference to
`acpi_numa_memory_affinity_init'
drivers/built-in.o(.init.text+0x3199): In function
`acpi_numa_init':
: undefined reference to `acpi_numa_arch_fixup'
make: *** [.tmp_vmlinux1] Error 1
How can i compile this without commenting these lines.

Thanks.


__________________________________
Do you Yahoo!?
New Yahoo! Photos - easier uploading and sharing.
http://photos.yahoo.com/
