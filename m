Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316827AbSGHJUg>; Mon, 8 Jul 2002 05:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316831AbSGHJUf>; Mon, 8 Jul 2002 05:20:35 -0400
Received: from 62-190-203-21.pdu.pipex.net ([62.190.203.21]:43781 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S316827AbSGHJUf>; Mon, 8 Jul 2002 05:20:35 -0400
From: jbradford@dial.pipex.com
Message-Id: <200207080927.KAA00734@darkstar.example.net>
Subject: Re: spurious 8259A interrupt: IRQ7
To: pat@cs.curtin.edu.au (Patrick Clohessy)
Date: Mon, 8 Jul 2002 10:27:41 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D2957A9.6D90A916@cs.curtin.edu.au> from "Patrick Clohessy" at Jul 08, 2002 05:13:13 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I was just wondering if anyone could help me solve a problem I'm having.
> I have installed red hat 7.3 with kernel version 2.4.18 on an AMD Duron
> 1100 with a ASUS A7V133-C Motherboard, 32MB TNT2 and a 20 GIG Maxtor
> Viper HD. Whenever the machine boots up, the following error appears :
> 
> spurious 8259A interrupt: IRQ7
> 
> I have read through quite a few mailing lists and other sources but
> can't find an adequate solution. One solution I found was to turn off
> Local APIC support and IO-APIC support in the kernel, which I tried and
> it worked, but I'd rather not do this. I realise the error isn't of a
> huge concern but it's still annoying having it appear everytime the
> machine boots up.
> 
> Any help will be greatly appreciated.

Why not just comment out the line in the kernel source that prints the error?  I know it sounds stupid, but it will solve your problem :-).

John.
