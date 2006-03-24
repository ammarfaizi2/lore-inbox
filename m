Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422808AbWCXJjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422808AbWCXJjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 04:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422807AbWCXJjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 04:39:05 -0500
Received: from palrel12.hp.com ([156.153.255.237]:54963 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1422804AbWCXJjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 04:39:04 -0500
Date: Fri, 24 Mar 2006 01:34:27 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-ia64@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, nigel.croxon@hp.com
Subject: gnu-efi-3.0c is available
Message-ID: <20060324093427.GC28939@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have released a new version of the GNU-EFI package.
This package is used to build EFI applications on Linux
for both IA-32 and IA-64 architectures.

This is a maintenance release with no new features just
updates to support the latest GNU compilers:

	- updated linker scripts to support latest gcc sections.
	  Provided by H.J. Lu from Intel. Special thanks to Jim Wilson
	  for his help.

	- updated library to compile cleanly with gcc4.1.
	  Provided by Raymund Will from SuSE

I have tested the package on Linux/ia64 with Debian gcc-4.0.3
and binutils 2.16.91. With this, you can build a working elilo3.6.

It compiles on Debian/i386 with gcc 4.0.3 and binutils 2.6.91.
I dot have the setup to test i386 efi
binaries.

You can grab the package at:
	ftp://ftp.hpl.hp.com/pub/linux-ia64/gnu-efi-3.0c.tar.gz
	MD5SUM: 823e5f04d1c0a7b88831f91fbf12d470

This is the last gnu-efi release that I manage. I am handing over
the maintenance of the package to Nigel Croxon from HP. Please forward
any new questions to him from now on. He is copied on this announcement.

Thanks.

-- 
-Stephane
