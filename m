Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266302AbUANFkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 00:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266303AbUANFkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 00:40:14 -0500
Received: from postino3.prima.com.ar ([200.42.0.148]:8974 "HELO
	postino3.prima.com.ar") by vger.kernel.org with SMTP
	id S266302AbUANFkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 00:40:10 -0500
Date: Wed, 14 Jan 2004 02:42:34 -0300
From: Horacio de Oro <hgdeoro@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.1-mm2] Badness in futex_wait at kernel/futex.c:509
Message-Id: <20040114024234.015eaf21.hgdeoro@yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This happen every time I switch from X to console:

Badness in futex_wait at kernel/futex.c:509
Call Trace:
 [futex_wait+434/448] futex_wait+0x1b2/0x1c0
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [do_futex+112/128] do_futex+0x70/0x80
 [sys_futex+292/320] sys_futex+0x124/0x140
 [syscall_call+7/11] syscall_call+0x7/0xb

Others messages found in syslog:

Badness in futex_wait at kernel/futex.c:509
Call Trace:
 [futex_wait+434/448] futex_wait+0x1b2/0x1c0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [do_futex+112/128] do_futex+0x70/0x80
 [sys_futex+292/320] sys_futex+0x124/0x140
 [syscall_call+7/11] syscall_call+0x7/0xb

I do not get these messages with 2.6.1.

If more information is needeed, please send me an email
to hgdeoro@yahoo.com

Thanks!
Horacio de Oro
