Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264096AbUDOOZZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 10:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264080AbUDOOZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 10:25:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:54913 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264114AbUDOOZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 10:25:12 -0400
Date: Thu, 15 Apr 2004 07:19:58 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Coywolf Qi Hunt <coywolf@greatcn.org>
Cc: bgerst@didntduck.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more i386 head.S cleanups
Message-Id: <20040415071958.27dbdd59.rddunlap@osdl.org>
In-Reply-To: <407E98BB.5070502@greatcn.org>
References: <406ECAE7.1020407@quark.didntduck.org>
	<407E98BB.5070502@greatcn.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004 22:14:19 +0800 Coywolf Qi Hunt wrote:

| Brian Gerst wrote:
| 
| > - Move empty_zero_page and swapper_pg_dir to BSS.  This requires that 
| > BSS is cleared earlier, but reclaims over 3k that was lost due to page 
| > alignment.
| > - Move stack_start, ready, and int_msg, boot_gdt_descr, idt_descr, and 
| > cpu_gdt_descr to .data.  They were interfering with disassembly while in 
| > .text.
| > 
| 
| Interesting, two years ago in 2002, you sent a patch basically of the
| same idea.
| 
| http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.0/0850.html

and your point is??

--
~Randy
