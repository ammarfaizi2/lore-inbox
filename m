Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbVDYSPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVDYSPo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 14:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVDYSPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 14:15:44 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:4493 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262702AbVDYSPg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 14:15:36 -0400
Message-ID: <426D33BA.8040604@tiscali.de>
Date: Mon, 25 Apr 2005 20:15:22 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050406)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
References: <426CD1F1.2010101@tiscali.de> <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org> <426D21FE.3040401@tiscali.de> <Pine.LNX.4.58.0504251021280.18901@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504251021280.18901@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 25 Apr 2005, Matthias-Christian Ott wrote:
> 
>>"register" and "auto" variables aren't relicts of the 60's,  they're a 
>>part of the ISO-C 99 standard, I'm following, "man".
> 
> 
> They _are_ relicts of the 60's. It's just that the C standard hasn't ever 
> had the reason to remove them.
> 
> 
>>And if you think "register" variables are outdated, please remove the 
>>CONFIG_REGPARM option from the Kernel source.
> 
> 
> That does something totally different. And doesn't use "register" at all.
> 
> Pass the toke, you've been hogging the drugs for way too long.
> 
> 		Linus
> 
But this makes, like "register",  direct use of processor registers (it stores int arguments in eax, ebx, etc.).

Matthias-Christian Ott
