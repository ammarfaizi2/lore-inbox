Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbULHWdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbULHWdx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 17:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbULHWdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 17:33:53 -0500
Received: from [82.147.40.124] ([82.147.40.124]:13442 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S261390AbULHWd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 17:33:29 -0500
Subject: CD-burning with SCSI cd-recorder.
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 08 Dec 2004 23:33:24 +0100
Message-Id: <1102545204.8001.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was under the impression that from kernel 2.6.10-rc1 or something, it
should be possible to burn cd's as an unpriviledged user again if you
have a 100% mmc-compatible cd-recorder.

This does not work here. Is it because my cd-recorder is SCSI? Or is it
not 100% mmc compatible, even though cdrecord says it is?

Here's the output:

stianj@chevrolet:/tmp$ cdrecord -dev=1,5,0 test.iso
cdrecord: No write mode specified.
cdrecord: Asuming -tao mode.
cdrecord: Future versions of cdrecord may have different drive dependent
defaults.
cdrecord: Continuing in 5 seconds...
Cdrecord-Clone 2.01a38 (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jörg
Schilling
NOTE: this version of cdrecord is an inofficial (modified) release of
cdrecord
      and thus may have bugs that are not present in the original
version.
      Please send bug reports and support requests to
<cdrtools@packages.debian.org>.
      The original author should not be bothered with problems of this
version.

cdrecord: Warning: Running on Linux-2.6.10-rc3
cdrecord: There are unsettled issues with Linux-2.5 and newer.
cdrecord: If you have unexpected problems, please try Linux-2.4 or
Solaris.
scsidev: '1,5,0'
scsibus: 1 target: 5 lun: 0
Linux sg driver version: 3.5.31
Using libscg version 'schily-0.8'.
cdrecord: Cannot allocate memory. Cannot get SCSI I/O buffer.
stianj@chevrolet:/tmp$

Is this expected? It's kinda not nice to start Gnome as root, to be able
to use nautilus-cd-burner...

Best regards,
Stian

