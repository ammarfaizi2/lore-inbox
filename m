Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWGBRiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWGBRiw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 13:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWGBRiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 13:38:52 -0400
Received: from terminus.zytor.com ([192.83.249.54]:32926 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751441AbWGBRiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 13:38:51 -0400
Message-ID: <44A80471.1020406@zytor.com>
Date: Sun, 02 Jul 2006 10:37:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59:	undefined
 reference to `__stack_chk_fail'
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com>	 <1151788673.3195.58.camel@laptopd505.fenrus.org>	 <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com>	 <1151789342.3195.60.camel@laptopd505.fenrus.org>	 <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com>	 <1151826131.3111.5.camel@laptopd505.fenrus.org>	 <a44ae5cd0607021007v52dac771n86c25c3bff491152@mail.gmail.com> <1151861523.3111.19.camel@laptopd505.fenrus.org>
In-Reply-To: <1151861523.3111.19.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
>> Does this mean that you don't want to see these fno-stack-protector
>> patches go into Andrew's tree?
> 
> long term.. no. Because I want to enable stack-protector for the kernel
> (I have patches for that; all it needs is a 5 line gcc patch to make it
> work) as debug option at least (and if the perf impact isn't too bad,
> distros and security sensitive people can enable it always). 
> 

Obviously, but at that time we should enable -fno-stack-protector vs 
-fstack-protector as appropriate.

	-hpa
