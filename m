Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311536AbSDANIX>; Mon, 1 Apr 2002 08:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311530AbSDANIP>; Mon, 1 Apr 2002 08:08:15 -0500
Received: from imladris.infradead.org ([194.205.184.45]:25616 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S311519AbSDANIJ>; Mon, 1 Apr 2002 08:08:09 -0500
Date: Mon, 1 Apr 2002 14:08:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: 1.0.9hch1
Message-ID: <20020401140808.A21512@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patchkit against Linux 1.0.9, largely based upon Paul
Gortmakers linux-lite patch. Why this new kernel release?

After all the discussions about VFS races and VM problems and growing bloat
in all areas of the kernel people seem to have forgotten the good old days
of the small and simple linux kernels.
Even more important the ego of a young kernel developer will suffer
in the long term if he doesn't have his own kernel patchkit, so here it is:

URL:

	ftp://ftp.kernel.org/pub/linux/kernel/people/hch/kernels/v1.0/1.0.9hch1.gz
	ftp://ftp.kernel.org/pub/linux/kernel/people/hch/kernels/v1.0/1.0.9hch1/


Contents:

00_elf-1

	Allow building the kernel as ELF binary.

00_elf-ksyms-1

	Fix kernel symbol table generation for ELF.
	(Don't apply this if you are still builing a.out kernels)

00_ext3-1 

	Preliminary ext3 support.

00_gcc272-1

	Fixes for building with gcc 2.7.2.

00_idle_hlt-1

	Call the i386 'hlt' instruction in the idle loop.

00_ifnet_unused-1

	Comment out unused struct ifnet methods to avoid compiler warnings.

00_includes-1

	Fix #include breakage.

00_isofs-1

	Rewrite isofs_match to avoid inline assembly.

00_makefiles-1

	Fix up makefile rules for assembly source files.

00_mmap-PROT_NONE-1

	Fix do_mmap problems.

00_mprotect-1

	Fake mprotect() success to emulate never kernels.

00_proc_debug-1

	Disable DEBUG_PROC_TREE - it has proven stable in years of
	carefull testing.

00_ultrastore-1

	Fix ultrastore driver atomic ops bugs.

00_user-headers-1

	Don't include userspace headers.

00_voxware25-1

	Import Voxware 2.5.

00_warnings-1

	Fix a large number of compiler warnings.

00_zboot-1

	Fix compressed boot header problems.


