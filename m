Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263830AbTLEDX2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 22:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbTLEDX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 22:23:28 -0500
Received: from hoemail2.lucent.com ([192.11.226.163]:54758 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263830AbTLEDX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 22:23:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16335.63931.101809.717476@gargle.gargle.HOWL>
Date: Thu, 4 Dec 2003 22:21:31 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: "John Stoffel" <stoffel@lucent.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, grundig@teleline.es,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP Kernel 2.6.0-test11 doesn't boot on a Dell 410
In-Reply-To: <16335.44623.99755.811085@gargle.gargle.HOWL>
References: <Pine.LNX.4.58.0312041607180.27578@montezuma.fsmlabs.com>
	<16335.44623.99755.811085@gargle.gargle.HOWL>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a quick followup.  I haven't booted into a Non-SMP kernel yet,
but when I compiled it, I got the following error:

  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux
  AS      arch/i386/boot/setup.o
arch/i386/boot/setup.S: Assembler messages:
arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to
  0x37ffffff
  LD      arch/i386/boot/setup
  OBJCOPY arch/i386/boot/compressed/vmlinux.bin
  GZIP    arch/i386/boot/compressed/vmlinux.bin.gz
  LD      arch/i386/boot/compressed/piggy.o
  LD      arch/i386/boot/compressed/vmlinux
  OBJCOPY arch/i386/boot/vmlinux.bin
  BUILD   arch/i386/boot/bzImage


I'm not sure if this is a valid error, or just a tool chain issue.

Some too versions:

gcc 3.3.2 (Debian)
as  2.14.90.0.7 20031029 Debian GNU/Linux

John
