Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTKGX6E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTKGWNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:13:10 -0500
Received: from calisto.ae.poznan.pl ([150.254.37.3]:26776 "EHLO
	calisto.ae.poznan.pl") by vger.kernel.org with ESMTP
	id S264413AbTKGPgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 10:36:39 -0500
Date: Fri, 7 Nov 2003 16:36:32 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: 2.6: value 0x37ffffff truncated to 0x37ffffff
Message-ID: <Pine.LNX.4.51.0311071628470.5963@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Rating: 0 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

during make bzImage on 2.6 I notoriously get this warning:

[exerpt]
  LD      vmlinux
  AS      arch/i386/boot/setup.o
arch/i386/boot/setup.S: Assembler messages:
arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 0x37ffffff
  LD      arch/i386/boot/setup
  OBJCOPY arch/i386/boot/compressed/vmlinux.bin
[eo exerpt]

I have been browsing through the archives and I got the feeling
that this has been already been approached. But I am getting this
since I ever tried 2.5 (about 2.5.53). By 2.6.0-test9-bk11 it is
still there. I have been compiling on 2 different machines. I have
their specs.

Is there anything I could supply to try to resolve this?

Maybe it's no biggy.

Regards,
Maciej

