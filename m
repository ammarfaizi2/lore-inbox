Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266057AbUFEJhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266057AbUFEJhq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 05:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266045AbUFEJhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 05:37:46 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:65156 "HELO
	develer.com") by vger.kernel.org with SMTP id S266057AbUFEJhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 05:37:43 -0400
Message-ID: <40C19463.3080405@develer.com>
Date: Sat, 05 Jun 2004 11:37:39 +0200
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: uClinux Mailing List <uclinux-dev@uclinux.org>,
       GCC Mailing List <gcc@gcc.gnu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       CrossGCC Mailing List <crossgcc@sources.redhat.com>,
       ColdFire Mailing List <ColdFire@lists.wildrice.com>
Subject: [ANNOUNCE] GCC 3.4 ColdFire/ARM toolchain for uClinux (20040604)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

a new version of the uClinux cross-compiler toolchain
based on GCC 3.4 is available here:

 http://www.uclinux.org/pub/uClinux/uclinux-elf-tools/gcc-3/

This release adds preliminary ARM support and includes
binaries for Linux (both glibc23 and glibc22 distros) and
Cygwin.

Many other things have been changed since the last public
announcement:


Changes in release 20040605:
        * Preliminary GCC 3.5 support.
        * Add some GCC 3.4 patches by Peter Barada.
        * Add support for GDB 6.1.
        * Update m68k-bdm to 1.3.0 and use GDB patches distributed with it.
        * Integrate preliminary ARM support.
        (Contributed by Steve Miller <steve.miller@st.com>).
        * Fix genromfs patch for CygWin.
        (Reported by Jens Heilig <jens@familie-heilig.net>).

Changes in release 20040425:
        * Update GCC 3.4 to the official 3.4.0 release.
        * Update m68k-bdm to 1.2.0.

Changes in release 20040323:
        * Update GCC 3.4 to the 20040317 snapshot.
        * Update binutils to 2.15.90.0.1.1, which already contains all
        the required uClinux patches.
        * Backport argument pointer corruption fix to GCC 3.3.3

Changes in release 20040309:
        * Drop Insight support (DDD is better anyway) and install GDB in $PREFIX.
        * Rename "interrupt" attribute to "interrupt_handler" in 3.3.x patches
        to match GCC 3.4.

Changes in release 20040112:

        * Update GCC 3.4 to 3.4-20040114.
        * Update uClibc to 0.9.26.
        * Update binutils to 2.14.90.0.8 (and drop some integrated patches).
        * Cleanup support for backwards compatibility links to m68k-elf- tools.
        * Correctly detect GCC version for interim releases.
        * Apply a couple of rogue patches to GCC 3.4.
        * Fix build with gcc-java, but don't expect it to work right now.

Changes in release 20031230:

        * Switch to m68k-uclinux for all components of the GCC 3.4 toolchain.
        * GCC's compiler driver now adds required linker flags when building
        executables with -mid-shared-libary.
        * Update uClibc to 0.9.24.
        * Update m68k-bdm to 20031207 and import latest GDB patches.
        * Update GCC 3.4 to 3.4-20031222.
        * Update GCC 3.3.x to 3.3-20031222.
        * Merge-in patches by Andrea Tarani for uClibc 0.9.23 and m68k-bdm.


-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

