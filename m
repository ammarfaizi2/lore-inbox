Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbVL0OSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVL0OSv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 09:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVL0OSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 09:18:44 -0500
Received: from mail.gmx.net ([213.165.64.21]:30360 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932336AbVL0OSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 09:18:15 -0500
X-Authenticated: #22464857
Message-ID: <43B14D1A.8010608@gmx.de>
Date: Tue, 27 Dec 2005 12:18:02 -0200
From: "nashleon@gmx.de" <nashleon@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Is there any Buffer overflow attack mechanism that can break
 a	vulnerable server without breaking the ongoing connection?
References: <4ae3c140512261247p612146f5w6ad8bf474f4ebfd5@mail.gmail.com> <1135630282.3910.8.camel@laptopd505.fenrus.org>
In-Reply-To: <1135630282.3910.8.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven escreveu:

>buffer overflows do not break connections, and as such I think you are
>out of luck.
>Having said that.. on modern linux distros it's pretty hard to do a
>buffer overflow exploit nowadays (NX[1] to make stacks non-executable,
>randomisations, compiler based detection (via FORTIFY_SOURCE and/or
>-fstackprotector)... add all those together and it's certainly not easy
>to do this....
>
>
>
>[1] or emulations of NX such as segment limits techniques
>
>  
>

Hello!

Locally is very simple to exploit buffer overflows in the linux kernel. 
This protections is not
efective very well, so it's possible many attacks... It's possible to 
return in mmap() area,
overwrite values em syscall table and after that run malicious code 
using mmap() to allocate
data and many others schemes and techniques.

Linux is very robust and its resources is very good, but it is not yet 
the solution against buffer overflows.

Best Regards,

Nash Leon 
