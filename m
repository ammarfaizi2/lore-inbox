Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265872AbUGITxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbUGITxi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 15:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265833AbUGITxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 15:53:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:48284 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265872AbUGITvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 15:51:47 -0400
Date: Fri, 9 Jul 2004 12:47:04 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: fastboot@lists.osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] kexec 2.6.7-v2 and kexec-tools-1.95
Message-Id: <20040709124704.1874a10b.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The kexec patch has been updated a bit (but this is still diffed
against 2.6.7 vanilla).  It WorksForMe (x86-32), using kexec-tools
(/sbin/kexec) to reboot or using sysvinit reboot (with patch
below) to reboot.  /sbin/kexec is used to load the new kernel
image in either case.

PPC32/GameCube port is now added here.  It's home is
  http://www.gc-linux.org/down/isobel/kexec/

There is ongoing work and/or interest in ports for PPC64,
IA-64, and x86-64, but I haven't seen code for them (yet).




http://developer.osdl.org/rddunlap/kexec/2.6.7-v2/

kexec-267-v2.diff
. kexec kernel patch for 2.6.7, with patches from Albert, Eric, Randy

gc-linux-2.6.7-isobel.kexec.patch
. GameCube patch (Albert Herranz)

README
. what kexec is, how to use it

Changelog
. actually updated, for a change



http://developer.osdl.org/rddunlap/kexec/kexec-tools/

sysvinit-2.85-kexec.patch
. sysvinit halt.c patch for kexec reboot (Eric, Albert)

kexec-tools-1.95.tar.gz
. kexec-tools-1.95 tarball with
  PPC64 support (Adam Litke),
  GameCube/PPC32 support (Albert),
  use syscall() for kexec_load() and reboot() (Randy),
  no-ifdown patch (Albert)

News
. changelog updated

--
~Randy
