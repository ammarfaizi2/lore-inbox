Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290547AbSA3UXT>; Wed, 30 Jan 2002 15:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290550AbSA3UXI>; Wed, 30 Jan 2002 15:23:08 -0500
Received: from imailg2.svr.pol.co.uk ([195.92.195.180]:63564 "EHLO
	imailg2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S290547AbSA3UW6>; Wed, 30 Jan 2002 15:22:58 -0500
Date: Wed, 30 Jan 2002 20:22:54 +0000
To: linux-kernel@vger.kernel.org, linux-lvm@sistina.com, lvm-devel@sistina.com
Subject: [ANNOUNCE] LVM reimplementation ready for beta testing
Message-ID: <20020130202254.A7364@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Joe Thornber <thornber@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Sistina is pleased to announce that the LVM2 software is ready for
beta testing.

This is a complete reimplementation of the existing LVM system, both
driver and userland tools.

We encourage you to give it a try and feed back your test results,
bug-fixes, enhancement requests etc. through the normal lists
linux-lvm@sistina.com and lvm-devel@sistina.com.

The new kernel driver (known as "device-mapper") supports volume
management in general and is no longer Linux LVM specific.
As such it is a separate package from LVM2 which you will need
to download and install before building LVM2.

 ftp://ftp.sistina.com/pub/LVM2/device-mapper/device-mapper-beta1.tgz


The userland tools are available from here:

 ftp://ftp.sistina.com/pub/LVM2/tools/LVM2.0-beta1.tgz


This release does not support snapshots or pvmove.  These features
will go into a subsequent beta release, hopefully within the next
fortnight.

This is Beta software which is *not* meant to be running on your
production systems.  If necessary, keep backups of your data and LVM
metadata (/etc/lvmconf/*).


We look forward to your feedback.


The Sistina LVM team:

      Patrick Caulfield,
      Alasdair Kergon,
      Heinz Mauelshagen,
      Joe Thornber
