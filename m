Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268286AbTBYVmo>; Tue, 25 Feb 2003 16:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268290AbTBYVmo>; Tue, 25 Feb 2003 16:42:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50444 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268286AbTBYVmn>; Tue, 25 Feb 2003 16:42:43 -0500
Message-ID: <3E5BE59B.6000409@zytor.com>
Date: Tue, 25 Feb 2003 13:52:27 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: zImage now holds vmlinux, System.map and config in sections.
 (fwd)
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se> <20030225092520.A9257@flint.arm.linux.org.uk> <b3gi0e$g2i$1@cesium.transmeta.com> <20030225212457.G21014@flint.arm.linux.org.uk>
In-Reply-To: <20030225212457.G21014@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
>>
>>Isn't that what "strip" is for?
> 
> zImage on ARM is a binary blob without any formatting.  The first
> instruction to be executed is at the start of the file.  Perfect
> for loading directly into flash or RAM via whatever boot loader
> or debugger you choose.
> 

Well, then it doesn't have sections.  As far as I could see the original
post only applied to architectures for which zImage is an ELF binary.

Similarly, this will not exist on x86/x86-64 where the (b)zImage is
mostly a binary blob.

	-hpa

