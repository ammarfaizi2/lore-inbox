Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265870AbTFSRxb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 13:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265871AbTFSRxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 13:53:31 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:55984 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S265870AbTFSRx3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 13:53:29 -0400
Subject: [2.5-bk] make[1]: warning: jobserver unavailable: using  =?ISO-8859-1?Q?=20-j1.=C2=A0?= Add
	`+' to parent make rule.
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1056046044.1664.36.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 19 Jun 2003 12:07:24 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know how long this message has been appearing. I just noticed
it today with the current 2.5 tree.

I did a make -j3 bzImage. Make version is 3.79.1.

Here is a snippet from the log:

  CC      net/xfrm/xfrm_output.o
  LD      net/xfrm/built-in.o
  LD      net/built-in.o
  GEN     .version
make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      vmlinux

Steven



