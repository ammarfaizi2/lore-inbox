Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbTFQLSp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 07:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264662AbTFQLSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 07:18:45 -0400
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:38887 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264660AbTFQLSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 07:18:43 -0400
Date: Tue, 17 Jun 2003 07:31:54 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: LD error building 2.5.71-bk2
Message-ID: <Pine.LNX.4.44.0306170730040.27006-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  apologies if this was covered already as i just resubscribed,
but trying to move up from 2.5.71-bk1 to 2.5.71-bk2 generated the
following in trying to build using the same .config file:

... snip ...

  CC      drivers/video/logo/logo_linux_clut224.o
  LD      drivers/video/logo/built-in.o
  LD      drivers/video/built-in.o
  LD      drivers/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
net/built-in.o(.init.text+0x20b): In function `flow_cache_init':
: undefined reference to `register_cpu_notifier'
make: *** [.tmp_vmlinux1] Error 1



rday

--

Robert P. J. Day
Eno River Technologies
Unix, Linux and Open Source training
Waterloo, Ontario

www.enoriver.com

