Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267222AbTBQR7c>; Mon, 17 Feb 2003 12:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267235AbTBQR7c>; Mon, 17 Feb 2003 12:59:32 -0500
Received: from [66.238.160.78] ([66.238.160.78]:1037 "EHLO quark.didntduck.org")
	by vger.kernel.org with ESMTP id <S267222AbTBQR7b>;
	Mon, 17 Feb 2003 12:59:31 -0500
Message-ID: <3E5124AC.80505@didntduck.org>
Date: Mon, 17 Feb 2003 13:06:36 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Osamu Tomita <tomita@cinet.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Christoph Hellwig'" <hch@infradead.org>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (16/26) NIC
References: <20030217134333.GA4734@yuzuki.cinet.co.jp> <20030217141552.GP4799@yuzuki.cinet.co.jp> <3E5115BB.6020407@pobox.com>
In-Reply-To: <3E5115BB.6020407@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>  > -#ifdef __ISAPNP__   
>  > +#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
> 
> 
> I am curious, does PC9800 support ISAPNP at all?
> 
> Perhaps a dumb question, but I wonder if the above ifdef can be 
> simplified by turning off ISAPNP on PC9800?

As long as the machine has ISA expansion slots, ISAPNP is possible.  It 
is a property of the card, not the system.

--
				Brian Gerst


