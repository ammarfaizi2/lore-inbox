Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbSLQUtE>; Tue, 17 Dec 2002 15:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265506AbSLQUtE>; Tue, 17 Dec 2002 15:49:04 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:65291 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265469AbSLQUtD>; Tue, 17 Dec 2002 15:49:03 -0500
X-WebMail-UserID: rtilley
Date: Tue, 17 Dec 2002 15:57:01 -0500
From: rtilley <rtilley@vt.edu>
To: linux-kernel@vger.kernel.org
X-EXP32-SerialNo: 00002964
Subject: 2.5.52 compile error
Message-ID: <3E058049@zathras>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: WebMail (Hydra) SMTP v3.61.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using RH's default *i686.config to build a vanilla 2.5.52 kernel. It keeps 
returning this error on 2 totally different x86 PCs:


drivers/built-in.o: In function `kd_nosound':
drivers/built-in.o(.text+0x1883f): undefined reference to `input_event'
drivers/built-in.o(.text+0x18861): undefined reference to `input_event'
drivers/built-in.o: In function `kd_mksound':
drivers/built-in.o(.text+0x1890a): undefined reference to `input_event'
drivers/built-in.o: In function `kbd_bh':
drivers/built-in.o(.text+0x197a2): undefined reference to `input_event'
drivers/built-in.o(.text+0x197c1): undefined reference to `input_event'
drivers/built-in.o(.text+0x197e0): more undefined references to `input_event' 
follow
drivers/built-in.o: In function `kbd_connect':
drivers/built-in.o(.text+0x19d54): undefined reference to `input_open_device'
drivers/built-in.o: In function `kbd_disconnect':
drivers/built-in.o(.text+0x19d7f): undefined reference to `input_close_device'
drivers/built-in.o: In function `kbd_init':
drivers/built-in.o(.init.text+0x12c1): undefined reference to 
`input_register_handler'
make: *** [.tmp_vmlinux1] Error 1


Where is the fix for this?

