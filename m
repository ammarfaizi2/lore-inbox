Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVJJN6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVJJN6E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 09:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVJJN6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 09:58:04 -0400
Received: from seqima.han-solo.net ([83.138.65.243]:39081 "EHLO
	seqima.han-solo.net") by vger.kernel.org with ESMTP
	id S1750802AbVJJN6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 09:58:01 -0400
Message-ID: <434A7363.40002@gmx.de>
Date: Mon, 10 Oct 2005 15:57:55 +0200
From: Georg Lippold <georg.lippold@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
References: <4315B668.6030603@gmail.com> <43162148.9040604@zytor.com>	 <20050831215757.GA10804@taniwha.stupidest.org>	 <431628D5.1040709@zytor.com> <431DF9E9.5050102@gmail.com>	 <431DFEC3.1070309@zytor.com> <431E00C8.3060606@gmail.com>	 <4345A9F4.7040000@uni-bremen.de> <434A6220.3000608@gmx.de>	 <9a8748490510100621x7bc20c42g667cc083d26aaaa2@mail.gmail.com> <9e0cf0bf0510100632i79b4b4cdk24935724d6ab1ed7@mail.gmail.com>
In-Reply-To: <9e0cf0bf0510100632i79b4b4cdk24935724d6ab1ed7@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alon Bar-Lev wrote:
> 1. Why don't you put this variable at config, and allow the user to
> specify the length during configuration? I have a patch that does just
> that.

If you'd post it, it would probably get more attention :)

> 2. THE MOST IMPORTANT task is to update the documentation at
> i386/boot.txt so that it will state that boot protocol 2.02+ field
> cmd_line_ptr should not be truncated and can be up to 4K bytes.
> Also fix "The kernel command line is null-terminated string up to 255
> characters long,..." this is good for the old boot protocol, but not
> for the 2.02+ protocol.
> 
> Without this fix the bootloaders (Lilo, Grub) will not fix their
> code... So that users will still will not be able to use > 256 command
> line.

syslinux >=3.09 supports 512 chars.

Greetings,

Georg
