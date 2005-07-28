Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVG1PNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVG1PNN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVG1PLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 11:11:03 -0400
Received: from webmailv3.ispgateway.de ([62.67.200.115]:48015 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S261556AbVG1PJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 11:09:43 -0400
Message-ID: <1122563381.42e8f5359af84@www.domainfactory-webmail.de>
Date: Thu, 28 Jul 2005 17:09:41 +0200
From: Florian Engelhardt <dot@dot-matrix.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc3-mm3 acpi compile problems
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 213.143.195.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i get this warnings when compiling:

  CC      drivers/acpi/utilities/utalloc.o
drivers/acpi/utilities/utalloc.c: In function `acpi_ut_create_caches':
drivers/acpi/utilities/utalloc.c:107: warning: passing arg 3 of
`acpi_ut_create_list' from incompatible pointer type
drivers/acpi/utilities/utalloc.c:113: warning: passing arg 3 of
`acpi_ut_create_list' from incompatible pointer type
drivers/acpi/utilities/utalloc.c: In function `acpi_ut_allocate':
drivers/acpi/utilities/utalloc.c:324: warning: passing arg 2 of
`acpi_ut_trace_u32' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:342: warning: passing arg 2 of
`acpi_ut_ptr_exit' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:345: warning: passing arg 2 of
`acpi_ut_ptr_exit' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c: In function `acpi_ut_callocate':
drivers/acpi/utilities/utalloc.c:374: warning: passing arg 2 of
`acpi_ut_trace_u32' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:382: warning: passing arg 2 of
`acpi_ut_ptr_exit' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:391: warning: passing arg 2 of
`acpi_ut_ptr_exit' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:397: warning: passing arg 2 of
`acpi_ut_ptr_exit' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c: In function `acpi_ut_free_and_track':
drivers/acpi/utilities/utalloc.c:573: warning: passing arg 2 of
`acpi_ut_trace_ptr' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:580: warning: passing arg 2 of `acpi_ut_exit'
discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:592: warning: passing arg 3 of
`acpi_ut_debug_print' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:598: warning: passing arg 3 of
`acpi_ut_debug_print' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:600: warning: passing arg 2 of `acpi_ut_exit'
discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c: In function `acpi_ut_track_allocation':
drivers/acpi/utilities/utalloc.c:673: warning: passing arg 2 of
`acpi_ut_trace_ptr' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:679: warning: passing arg 2 of
`acpi_ut_status_exit' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:692: warning: passing arg 3 of
`acpi_ut_debug_print' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:722: warning: passing arg 2 of
`acpi_ut_status_exit' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c: In function `acpi_ut_remove_allocation':
drivers/acpi/utilities/utalloc.c:752: warning: passing arg 2 of `acpi_ut_trace'
discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:762: warning: passing arg 2 of
`acpi_ut_status_exit' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:767: warning: passing arg 2 of
`acpi_ut_status_exit' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:787: warning: passing arg 3 of
`acpi_ut_debug_print' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:791: warning: passing arg 2 of
`acpi_ut_status_exit' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c: In function `acpi_ut_dump_allocations':
drivers/acpi/utilities/utalloc.c:880: warning: passing arg 2 of `acpi_ut_trace'
discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:937: warning: passing arg 3 of
`acpi_ut_debug_print' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:941: warning: passing arg 3 of
`acpi_ut_debug_print' discards qualifiers from pointer target type
drivers/acpi/utilities/utalloc.c:946: warning: passing arg 2 of `acpi_ut_exit'
discards qualifiers from pointer target type
  CC      drivers/acpi/utilities/utdebug.o
make[3]: *** Deleting file `drivers/acpi/utilities/utdebug.o'
make[3]: *** wait: No child processes.  Stop.
make[3]: *** Waiting for unfinished jobs....
make[3]: *** wait: No child processes.  Stop.
make[2]: *** wait: No child processes.  Stop.
make[2]: *** Waiting for unfinished jobs....
make[2]: *** wait: No child processes.  Stop.
make[1]: *** wait: No child processes.  Stop.
make[1]: *** Waiting for unfinished jobs....
make[1]: *** wait: No child processes.  Stop.
make: *** [drivers] Error 2


Kind regards

Flo

