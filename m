Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUCVH0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 02:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbUCVH0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 02:26:37 -0500
Received: from mail.gmx.de ([213.165.64.20]:62429 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261798AbUCVH0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 02:26:36 -0500
X-Authenticated: #20450766
Date: Mon, 22 Mar 2004 08:25:54 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Richard Browning <richard@redline.org.uk>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Len Brown <len.brown@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       <linux-kernel@vger.kernel.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: ANYONE? Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel
 2.4.x 2.6.x / Crash/Freeze
In-Reply-To: <200403220104.10619.richard@redline.org.uk>
Message-ID: <Pine.LNX.4.44.0403220823020.2831-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Richard Browning wrote:

> As I suggested in the original post, the problem can be triggered simply by
> executing ./configure - the kernel corrupts when gcc does its thing. I can
> boot into KDE, run Enemy Territory, execute a Java compile, and so on. But
> the thing absolutely and most definitely able to upset the cart is to execute
> gcc.

Aha! A single thread? A specific asm insn? Is gcc --version enough to kill
the machine? Or on smth like
int main(void)
{return 0;}
gcc -E; gcc -S; gcc -c; ld? Step-by-step with gdb (hopefully, gdb doesn't
have this insn...). NMI watchdog?

Guennadi
---
Guennadi Liakhovetski


