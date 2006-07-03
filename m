Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWGCPKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWGCPKt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 11:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWGCPKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 11:10:49 -0400
Received: from terminus.zytor.com ([192.83.249.54]:1979 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751170AbWGCPKs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 11:10:48 -0400
Message-ID: <44A93344.5080609@zytor.com>
Date: Mon, 03 Jul 2006 08:09:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Miles Lane <miles.lane@gmail.com>
CC: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined
 reference to `__stack_chk_fail'
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com>	 <1151788673.3195.58.camel@laptopd505.fenrus.org>	 <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com>	 <1151789342.3195.60.camel@laptopd505.fenrus.org>	 <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com>	 <1151826131.3111.5.camel@laptopd505.fenrus.org>	 <a44ae5cd0607021007v52dac771n86c25c3bff491152@mail.gmail.com>	 <20060703051723.GA13415@elte.hu> <a44ae5cd0607030607y290edaa9ud492eb819d383329@mail.gmail.com>
In-Reply-To: <a44ae5cd0607030607y290edaa9ud492eb819d383329@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> 
> Well, I see that Andrew has accepted (mm5)
> the -fno-stack-protector patch for the Makefile, but klibc remains
> unpatched (scripts/Kbuild.klibc and usr/klibc/arch/i386/MCONFIG).
> Would the right person in this dialog submit those changes to Andrew?
> 

The fix is in my private tree, but given that we're in a merge window, I 
don't want to push it out right now until I've been able to figure out 
why an unrelated change cause make to spew warning messages.

	-hpa

