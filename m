Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbVJJPqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbVJJPqx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 11:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbVJJPqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 11:46:53 -0400
Received: from seqima.han-solo.net ([83.138.65.243]:46298 "EHLO
	seqima.han-solo.net") by vger.kernel.org with ESMTP
	id S1750860AbVJJPqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 11:46:52 -0400
Message-ID: <434A8CE8.2020404@gmx.de>
Date: Mon, 10 Oct 2005 17:46:48 +0200
From: Georg Lippold <georg.lippold@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com>	 <20050831215757.GA10804@taniwha.stupidest.org>	 <431628D5.1040709@zytor.com> <431DF9E9.5050102@gmail.com>	 <431DFEC3.1070309@zytor.com> <431E00C8.3060606@gmail.com>	 <4345A9F4.7040000@uni-bremen.de> <434A6220.3000608@gmx.de> <9a8748490510100621x7bc20c42g667cc083d26aaaa2@mail.gmail.com> <434A8082.9060202@zytor.com>
In-Reply-To: <434A8082.9060202@zytor.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
>>
>> Would it make sense to make it 1024 everywhere (and maybe move it out
>> of arch specific files and just set it in one central place) ?
>>
> 
> I would agree with that, *BUT* the boot protocol on each architecture
> need to be consistent.

> At the very least, though, i386 and x86-64 need to be changed together,
> since they use the same bootstrap.

I think it will take rather long to synchronize all archs. Maybe x86 can
fix it fast (it would ease the making of LiveCD's) and then initiate a
standardization on lkml? Knoppix has its kernel patch for over a year
now and I asked gentoo to do so, too. But they said, I should ask for it
here... Until the fix is in the distributions-kernel, probably another
month will pass and it obviously needs to be fixed.

Greetings,

Georg


