Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbTIPNAQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 09:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTIPNAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 09:00:16 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:33540 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S261794AbTIPNAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 09:00:12 -0400
Date: Tue, 16 Sep 2003 10:01:42 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: MAJEK <majek@witek.liceum64.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Computer was left to work at night, in the morning i
 saw only the panic messages.
In-Reply-To: <Pine.LNX.4.50.0309111217480.2308-300000@witek.liceum64.pl>
Message-ID: <Pine.LNX.4.44.0309160943200.1636-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Sep 2003, MAJEK wrote:

> [1.]
> Computer was left to work at night, in the morning i saw only the panic messages.
> [2.]
> Logs stop after three hours of working with no user. I have no idea what can crash.
> Bttv and usb modules were unloaded. Only cmpci.o and some codepages were
> loaded.
> Maybe it was acpi fault?(and maybe not)
> [3.]
> No idea.
> [4.]
> Linux version 2.4.22 (root@tigger) (gcc version 3.2) #1 Mon Sep 8 01:25:40 CEST 2003
> [5.]
> unable to handle kernel null pointer dereference at virtual adress 00000000
> *pde = 00000000
> oops = 2
> eip 0010:c0105386  tained p
> eflags 00010246
> eax 00000000 ebx c0105360 ecx 00000000 edx 00000000
> esi c0408000 edi c0408000 ebp c0409fcc esp c0409fcc
> ds 0018 es 0018 ss 0018
> proces swapper pid:0 stackpage c0409000
> stack
> c0409fe0 c0105402 00000000 000a0200 c0105000 c0409ff8 c040a72f c0373ec0
> c04597c0 00000000 c04596c0 0008e000 c0100191
> call trace
> c0105402 c0105000
> code
> c9 c3 fb eb fb 90 8d 74 26 00 55 89 e5 fb ba 00 e0 ff ff b8
> [6.]
> No code. Computer was left to work at night. After 3 hours he panicked.

You seem to be using proprietary nvidia module?

Can you transform the output in human readable format with ksymoops? 


