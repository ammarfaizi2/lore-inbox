Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTKDW14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 17:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbTKDW1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 17:27:55 -0500
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:37046 "HELO
	develer.com") by vger.kernel.org with SMTP id S261226AbTKDW1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 17:27:47 -0500
Message-ID: <3FA827D8.3000700@develer.com>
Date: Tue, 04 Nov 2003 23:27:36 +0100
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: uclinux-dev <uclinux-dev@uclinux.org>
CC: GCC Mailing List <gcc@gcc.gnu.org>,
       CrossGCC Mailing List <crossgcc@sources.redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] GCC 3.3.2/3.4 ColdFire toolchain for uClinux (20031103)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've released a new snapshot of the uClinux/ColdFire toolchain
based on GCC 3.3.2 and GCC 3.4-prerelease:

  http://www.uclinux.org/pub/uClinux/uclinux-elf-tools/gcc-3/

This release incorporares quite a lot of updates and fixes
since the last official announcement.

Changes in release 20031102:

    * Update GCC to 3.3.2 and 3.4-20031029;
    * Update binutils to version 2.14.90.0.7;
    * Finished integrating uClinux and ColdFire support in
      official GCC and binutils. The 3.4 toolchain now builds
      with no patches except for some pending GCC 3.4 bugfixes;
    * Use self-extracting archives for all binary packages;
    * Fix GCC 3.4 packaging problem (thanks to Frank Baumgart).

Changes in release 20031006:

    * Most ColdFire and uClinux patches are now incorporated
      in the official GCC 3.4 snapshots.
    * Update GDB to 6.0, with new BDM patches.
    * Update uClibc to 0.9.21.
    * Enable pthreads support in uClibc (lightly tested).
    * Split binary distribution in three packages (base, C++ and GDB).
    * Several bugfixes all over the build script and patches.

Changes in release 20030811:

    * Upgraded GCC 3.3.1 to the official release;
    * Update links for GCC 3.4 to really point at the 20030806
      snapshot.

Changes in release 20030808:

    * uClibc multilibs for -msep-data were being built as
      shared libraries (reported by Chen Qi).
    * Update elf2flt from uClinux CVS and drop all patches.
    * Update GCC 3.4 snapshot to 20030806. Fixes problems with -MD,
      builds kernel, breaks libstdc++ multilibs (still investigating).
    * Apply small fixes to GCC 3.4 patchset.
    * Integrate GDB 5.3 with BDM support
    * Restore building GCC 3.3.1 (got broken in previous release)
    * Test with GCC 2.95.3: surprisingly, it still builds fine...

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html



