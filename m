Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265042AbUFVRWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265042AbUFVRWF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbUFVRTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:19:37 -0400
Received: from holomorphy.com ([207.189.100.168]:18820 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265029AbUFVRSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:18:15 -0400
Date: Tue, 22 Jun 2004 10:18:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Juhani Pirttilahti <juhani.pirttilahti@mbnet.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel problem
Message-ID: <20040622171806.GF2135@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Juhani Pirttilahti <juhani.pirttilahti@mbnet.fi>,
	linux-kernel@vger.kernel.org
References: <200406221954150026.009597B0@smtp.ebaana.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406221954150026.009597B0@smtp.ebaana.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 07:54:15PM +0300, Juhani Pirttilahti wrote:
> "Screenshot":
> Unable to handle kernel paging request at virtual address 591bb01c
> printing eip: c0142104 *pde = 00000000
> Oops: 0002
> CPU: 0
> EIP: 0010:[<c0142104>] Not tainted
> EFLAGS: 00010202
> eax: 00000001 ebx: 591bafc0 ecx: 00000000 edx: 591bb01c
> esi: c02177cd edi: 591bb01c ebp: 00000000 esp: c0285f40
> ds: 0018 es: 0018 ss: 0018
> Process swapper (pid: 0, stackpage=c0285000)
> Stack: 00000000 c12143e0 c0246540 00000000 c0142235 00000000 c0285f5c c02177cd 00000001 00000000 c0246540 c1216800 c014d8ca c12143e0 c1216800 00000000 c0136b0c c1216800 00000000 00000000 cbfcc190 c0246540 fffffff4
> Call Trace: [<c0142235>] [<c0136b0c>] [<c0136bad>] [c0105000>] [<c0136cfc>]
> Code: a4 8b 4c 24 18 8b 41 04 c6 04 10 00 c7 03 01 00 00 00 c7 43
> <0>Kernel Panic: Attempted to kill the idle task!
> In idle task - not syncing

Could you run this through ksymoops or post the 2.6 oops?

Thanks.

-- wli
