Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264957AbUGBVG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbUGBVG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbUGBVFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:05:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:976 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264934AbUGBVE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:04:29 -0400
Date: Fri, 2 Jul 2004 14:03:22 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: limaunion@fibertel.com.ar, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm2 build errors...
Message-Id: <20040702140322.2ab47867.rddunlap@osdl.org>
In-Reply-To: <20040702205129.GK28324@fs.tum.de>
References: <40DCEFFB.5020605@fibertel.com.ar>
	<20040702205129.GK28324@fs.tum.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2004 22:51:29 +0200 Adrian Bunk wrote:

| On Sat, Jun 26, 2004 at 12:39:39AM -0300, limaunion wrote:
| 
| >   LD      .tmp_vmlinux1
| > arch/i386/kernel/built-in.o(.text+0xbe14): In function `powernow_acpi_init':
| > : undefined reference to `acpi_processor_register_performance'
| > arch/i386/kernel/built-in.o(.text+0xbe3b): In function `powernow_acpi_init':
| > : undefined reference to `acpi_processor_unregister_performance'
| > arch/i386/kernel/built-in.o(.exit.text+0x3b): In function `powernow_exit':
| > : undefined reference to `acpi_processor_unregister_performance'
| > make: *** [.tmp_vmlinux1] Error 1
| > 
| > This also happens in 2.6.7-mm1, I'm wondering if this is my fault or 
| > something's wrong?
| 
| It seems something is/was wrong.
| 
| Can you still reproduce it in 2.6.7-mm5?
| If yes, please send your .config.

Same as this problem report:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108752330915120&w=2

but my patch was insufficient:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108753512102539&w=2

See reply from Dave Jones.  And I see what he means, but I don't
see how to express it in Kconfig language.

--
~Randy
