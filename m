Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTJYSaK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 14:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTJYSaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 14:30:05 -0400
Received: from havoc.gtf.org ([63.247.75.124]:21902 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262758AbTJYS3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 14:29:35 -0400
Date: Sat, 25 Oct 2003 14:29:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [AMD64 0/3] description and URLS
Message-ID: <20031025182935.GA12165@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Requesting permission to send this to Linus...

BK users:

	bk pull bk://kernel.bkbits.net/jgarzik/bum-2.5

Patch available at

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test8-bk5-amd64-1.patch.bz2

This will update the following files:

 arch/x86_64/ia32/syscall32.c     |    4 +-
 arch/x86_64/kernel/acpi/boot.c   |   69 +++++++++++++++++++++++++++------------
 arch/x86_64/kernel/bluesmoke.c   |    8 ++--
 arch/x86_64/kernel/setup.c       |    2 -
 arch/x86_64/kernel/x8664_ksyms.c |    2 -
 5 files changed, 58 insertions(+), 27 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/10/25 1.1354)
   [BK] ignore x86-64 build generated files

<jgarzik@redhat.com> (03/10/25 1.1353)
   [AMD64] fix bcopy prototype
   
   Linus recently fixed the version in lib/

<jgarzik@redhat.com> (03/10/25 1.1352)
   [AMD64] add acpi_pic_set_level_irq
   
   ACPI guys broke the AMD64 build.  Adding this function fixes it.

<jgarzik@redhat.com> (03/10/25 1.1351)
   [AMD64] Fix C99-ish mix of declarations and code.

