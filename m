Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263987AbUDOOO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 10:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264079AbUDOOO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 10:14:27 -0400
Received: from everest.2mbit.com ([24.123.221.2]:59281 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S263987AbUDOOOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 10:14:25 -0400
Message-ID: <407E98BB.5070502@greatcn.org>
Date: Thu, 15 Apr 2004 22:14:19 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
Organization: GreatCN.org & The Summit Open Source Develoment Group
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, zh-cn, zh
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <406ECAE7.1020407@quark.didntduck.org>
In-Reply-To: <406ECAE7.1020407@quark.didntduck.org>
X-Scan-Signature: 5e46532232fd70c4de6004b73fafcbb3
X-SA-Exim-Connect-IP: 24.123.221.2
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: Re: [PATCH] more i386 head.S cleanups
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 4.0 (built Tue, 16 Mar 2004 14:56:42 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:

> - Move empty_zero_page and swapper_pg_dir to BSS.  This requires that 
> BSS is cleared earlier, but reclaims over 3k that was lost due to page 
> alignment.
> - Move stack_start, ready, and int_msg, boot_gdt_descr, idt_descr, and 
> cpu_gdt_descr to .data.  They were interfering with disassembly while in 
> .text.
> 

Interesting, two years ago in 2002, you sent a patch basically of the
same idea.

http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.0/0850.html


-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org


