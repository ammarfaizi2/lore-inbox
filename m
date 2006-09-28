Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbWI1TrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWI1TrW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 15:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbWI1TrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 15:47:22 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:48274 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1161042AbWI1TrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 15:47:21 -0400
From: Stephan Wiebusch <stephanwib@t-online.de>
Organization: Privat
To: linux-kernel@vger.kernel.org
Subject: Initrd and ramdisk support
Date: Thu, 28 Sep 2006 21:47:41 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609282147.41671.stephanwib@t-online.de>
X-ID: EwwjCMZd8eTtpiYiHI03A-t6e3HxY7Xh83ORYdnWFluQU7GaNJkGYv
X-TOI-MSGID: f1268eb5-8c0a-4aba-864b-ab2c11b74af3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After a very long session of searching for the reason for error messages like 

Unpacking initramfs...<0>Kernel panic - not syncing: bad gzip magic numbers
Unpacking initramfs...<0>Kernel panic - not syncing: no cpio magic

i luckily was able to determine the malefactor. There was the initrd support 
built into the kernel while the ramdisk driver was just built as a module.

Is it senseful to have the possibility to built the Initramfs/Initrd-support 
without having the ramdisk driver forced to be integrated also?

King regards from Germany
Stephan Wiebusch
