Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUF0SnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUF0SnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 14:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUF0SnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 14:43:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:31456 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261236AbUF0SnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 14:43:15 -0400
Date: Sun, 27 Jun 2004 11:42:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm3 USB ehci IRQ problem
Message-Id: <20040627114211.0353bc66.akpm@osdl.org>
In-Reply-To: <1088337721.7932.10.camel@paragon.slim>
References: <1088337721.7932.10.camel@paragon.slim>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurgen Kramer <gtm.kramer@inter.nl.net> wrote:
>
> With 2.6.7-mm3 I am missing my USB 2.0 memory stick. It doesn't show up
>  in the usb device listing. But when I unplug it I get:
> 
>  irq 23: nobody cared!
>   [<c0108106>] __report_bad_irq+0x2a/0x8b
>   [<c01081f0>] note_interrupt+0x6f/0x9f
>   [<c0108473>] do_IRQ+0x10c/0x10e
>   [<c0106850>] common_interrupt+0x18/0x20
>  handlers:
>  [<f9d0f65c>] (snd_emu10k1_interrupt+0x0/0x3c4 [snd_emu10k1])
>  Disabling IRQ #23

Could you please do a `patch -p1 -R' of
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm3/broken-out/bk-acpi.patch
?
