Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275316AbTHGM26 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 08:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275318AbTHGM26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 08:28:58 -0400
Received: from web40611.mail.yahoo.com ([66.218.78.148]:60309 "HELO
	web40611.mail.yahoo.com") by vger.kernel.org with SMTP
	id S275316AbTHGM2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 08:28:51 -0400
Message-ID: <20030807122850.99548.qmail@web40611.mail.yahoo.com>
Date: Thu, 7 Aug 2003 13:28:50 +0100 (BST)
From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Loading Pentium III microcode under Linux - catch 22!
To: tigran@veritas.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran,

I have an i840 motherboard with a pair of 933 MHz PIII
Coppermine CPUs, and I use your microcode driver to
load the latest Intel microcode into my CPUs. This is
very important because these CPUs are buggy without
their microcode, and I would prefer to have the BIOS
load it except that this would prevent me from booting
into memtest. I have tried this before - memtest
crashes with an "Unexpected Interrupt" error after a
few minutes. (No i840 workarounds enabled?) Since I
suspect that DOS would do the same thing and I would
boot into DOS to flash firmware, I have decided that
crashes like this would be a Bad Thing.

I have modified by boot scripts to load the microcode
as soon as the root filesystem has been successfully
mounted. However, this means that kernel always boots
on buggy CPUs! For example, last night my boot failed
just after releasing the unused kernel memory. I
suspect that the record temperatures that my part of
the world is currently experiencing is adversely
influencing things. My boot-ups are usually fine.

In an ideal world, I would like Linux to load the
microcode *before* the kernel boots, which begs the
question of "How?". Can you suggest anything, please?
I remember talk of boot-time RAM disks, and wondered
if the microcode could be placed on one of these
somehow? Or would that be ruled out immediately by the
microcode's non-GPL nature?

Any suggestions gratefully received,
Thanks,
Chris Rankin


________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://uk.messenger.yahoo.com/
