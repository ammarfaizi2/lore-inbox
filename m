Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274837AbTHAUvt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 16:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274955AbTHAUvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 16:51:49 -0400
Received: from law11-oe70.law11.hotmail.com ([64.4.16.205]:23560 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S274837AbTHAUvp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 16:51:45 -0400
X-Originating-IP: [165.98.111.210]
X-Originating-Email: [bmeneses_beltran@hotmail.com]
From: "Viaris" <bmeneses_beltran@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: problems compiling kernel 2.5.75
Date: Fri, 1 Aug 2003 14:51:32 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <Law11-OE70LwHc9ny7B0000e8d4@hotmail.com>
X-OriginalArrivalTime: 01 Aug 2003 20:51:44.0238 (UTC) FILETIME=[B75B80E0:01C3586E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, I ma compiling kernel version 2.5.75, but I have the folloienw
error:

drivers/built-in.o(.text+0x1d41e): In function `pc_close':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x1d423): In function `pc_close':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1d586): In function `shutdown':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x1d58b): In function `shutdown':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1d67e): In function `pc_hangup':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x1d683): In function `pc_hangup':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1d6bc): In function `pc_hangup':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1d7c0): In function `pc_write':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x1d7c5): In function `pc_write':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1d8e2): In function `pc_write':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1d908): In function `pc_write':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x1d90d): In function `pc_write':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1d990): In function `pc_write':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1daf2): In function `pc_write_room':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x1daf7): In function `pc_write_room':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1db6f): In function `pc_write_room':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1dbf0): In function `pc_chars_in_buffer':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x1dbf5): In function `pc_chars_in_buffer':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1dc61): In function `pc_chars_in_buffer':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1dcfe): In function `pc_flush_buffer':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x1dd03): In function `pc_flush_buffer':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1dd53): In function `pc_flush_buffer':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1ddfa): In function `pc_flush_chars':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x1ddff): In function `pc_flush_chars':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1df2d): In function `block_til_ready':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x1df32): In function `block_til_ready':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1df4d): In function `block_til_ready':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1dfd2): In function `block_til_ready':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1dfed): In function `block_til_ready':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1e1a4): In function `pc_open':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x1e1a9): In function `pc_open':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1e1fa): In function `pc_open':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1e221): In function `pc_open':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x1e226): In function `pc_open':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1e244): In function `pc_open':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1e9ec): In function `epcapoll':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x1e9f1): In function `epcapoll':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1ea3f): In function `epcapoll':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1f7f8): In function `pc_ioctl':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x1f8da): In function `pc_ioctl':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1f901): In function `pc_ioctl':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1fa5d): In function `pc_ioctl':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1fa8b): In function `pc_ioctl':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1fc26): In function `pc_ioctl':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1fce6): In function `pc_ioctl':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1fd74): In function `pc_ioctl':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1fe35): In function `pc_ioctl':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1fe70): In function `pc_ioctl':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1ff3e): In function `pc_ioctl':
: undefined reference to `cli'
drivers/built-in.o(.text+0x200ae): In function `pc_set_termios':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x200b3): In function `pc_set_termios':
: undefined reference to `cli'
drivers/built-in.o(.text+0x2021a): In function `pc_stop':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x2021f): In function `pc_stop':
: undefined reference to `cli'
drivers/built-in.o(.text+0x202fa): In function `pc_start':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x202ff): In function `pc_start':
: undefined reference to `cli'
drivers/built-in.o(.text+0x203ea): In function `pc_throttle':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x203ef): In function `pc_throttle':
: undefined reference to `cli'
drivers/built-in.o(.text+0x204ca): In function `pc_unthrottle':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x204cf): In function `pc_unthrottle':
: undefined reference to `cli'
drivers/built-in.o(.text+0x2056b): In function `digi_send_break':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x20570): In function `digi_send_break':
: undefined reference to `cli'
drivers/built-in.o(.text+0x205ea): In function `setup_empty_event':
: undefined reference to `save_flags'
drivers/built-in.o(.text+0x205ef): In function `setup_empty_event':
: undefined reference to `cli'
drivers/built-in.o(.text+0x1d4e9): In function `pc_close':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1d5cf): In function `shutdown':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x1de22): In function `pc_flush_chars':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x20119): In function `pc_set_termios':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x20239): In function `pc_stop':
: undefined reference to `restore_flags'
drivers/built-in.o(.text+0x20319): more undefined references to
`restore_flags' follow
drivers/built-in.o(.text+0x23f77): In function `stli_poll':
: undefined reference to `schedule_task'
drivers/built-in.o(.init.text+0x28f3): In function `pc_init':
: undefined reference to `save_flags'
drivers/built-in.o(.init.text+0x28f8): In function `pc_init':
: undefined reference to `cli'
drivers/built-in.o(.init.text+0x2a2a): In function `pc_init':
: undefined reference to `restore_flags'
make: *** [.tmp_vmlinux1] Error 1

How can i do ti to resolv?

Thanks in Advanced,


