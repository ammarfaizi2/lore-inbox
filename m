Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289576AbSAJRpS>; Thu, 10 Jan 2002 12:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289574AbSAJRpA>; Thu, 10 Jan 2002 12:45:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49162 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289575AbSAJRoo>; Thu, 10 Jan 2002 12:44:44 -0500
Message-ID: <3C3DD2F4.2090302@zytor.com>
Date: Thu, 10 Jan 2002 09:44:20 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Giacomo Catenazzi <cate@debian.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
In-Reply-To: <Pine.LNX.4.33.0201101841050.21159-100000@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> 
> If every combination for a given cpuid translates to the same CONFIG_
> option, fine. I'm just not sure from memory if thats the case or not.
> The various Celeron/PIII's for example, some have SSE, some don't.
> Assuming Intel cpuid xxx translates to CONFIG_PENTIUMIII would break if
> thats the case.
> 


Right, which is why you should look at the SSE feature flag and nothing 
else.

	-hpa


