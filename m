Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbUBEM6J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 07:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265221AbUBEM6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 07:58:09 -0500
Received: from kempelen.iit.bme.hu ([152.66.241.120]:58793 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S265218AbUBEM6E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 07:58:04 -0500
Date: Thu, 5 Feb 2004 13:58:02 +0100 (MET)
Message-Id: <200402051258.i15Cw2E20493@kempelen.iit.bme.hu>
From: Szeredi Miklos <mszeredi@inf.bme.hu>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [ANNOUNCE] Filesystem in Userspace (FUSE) 1.1 stable version
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This release adds support for the 2.6 Linux kernel series.  Other new
features include support for exporting FUSE filesystems over NFS, read
efficiency improvements, automatic lazy unmounting, the addition of
the fsync call, plus minor bugfixes and cleanups.

Download from:
  
  http://sourceforge.net/project/showfiles.php?group_id=21636&package_id=31956&release_id=214856

About:

FUSE is a combination of a kernel module and a userspace library that
makes the creation of filesystems in userspace very easy.  A "Hello
World" filesystem implementation is just 59 lines long (excluding
empty lines and comments).

There are currently a number of applications using FUSE in the
following categories: exporting internal state of devices (OWFS,
SieFS), exporting existing userspace virtual filesystems (KIO - FUSE
gateway, AVFS), network filesystems (SMB for FUSE, FunFS), encrypted
filesystems (EncFS, PhoneBook), exporting internal data of
applications (Run Time Access).  For more info about these see
'Filesystems' in the distribution.

In addition to the native C API, FUSE has bindings for a number of
other languages: Perl, Python, Java and C++.

FUSE was designed with the following goals in mind: very simple
userspace API, generic, efficient (but still simple) kernel API and
ability for non-root users to create and mount filesystems securely.

Future plans:

I plan to submit the next version (with a revised user - kernel
interface) for inclusion into the 2.6 and/or 2.7 kernels.  Still to do
is a modification of the mount syscall to allow non-root users to
mount FUSE filesystems (currently done with a suid-root helper
program).

Comments, flames, patches, bugreports are welcome!

Miklos
