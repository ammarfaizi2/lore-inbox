Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKFFt3>; Mon, 6 Nov 2000 00:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbQKFFtU>; Mon, 6 Nov 2000 00:49:20 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:36448 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129061AbQKFFtB>; Mon, 6 Nov 2000 00:49:01 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@linuxia64.org, linux-vm@vm.marist.edu
Subject: Announce: ksymoops 2.3.5 is available
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 16:47:34 +1100
Message-ID: <4943.973489654@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mirror at ftp://ftp.**.kernel.org/pub/linux/utils/kernel/ksymoops/v2.3
           replace '**' with your favourite local kernel.org mirror.

ksymoops-2.3.5.tar.gz		Source tarball, includes RPM spec file
ksymoops-2.3.5-1.src.rpm	As above, in SRPM format
ksymoops-2.3.5-1.i386.rpm	Compiled with egcs-2.91.66, glibc 2.1.2
patch-ksymoops-2.3.5.gz		Patch from 2.3.4.

Changelog extract

	* Handle SGI kdb initial report.
	* Static link against libbfd, libiberty to stop version problems.
	  Suggested by HJ Lu.
	* Add BUG to printed text.
	* Add wait_on_irq lines to printed text.
	* Handle weak references that have been resolved.
	* Support for IA64.
	* Add mandir to spec file.

	Ross Patterson <Ross.Patterson@CA.Com>
 	* Recognize s390 kernel PSW and registers.
 	* Don't try to decode s390 user PSW and registers.
 	* Set default target and architecture on recognition of i370 or s390
 	  kernel PSW (ala Oops_set_eip()).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
