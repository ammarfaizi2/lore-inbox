Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbTBQSX4>; Mon, 17 Feb 2003 13:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbTBQSXz>; Mon, 17 Feb 2003 13:23:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55826 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267277AbTBQSXz>;
	Mon, 17 Feb 2003 13:23:55 -0500
Message-ID: <3E512AF7.50802@pobox.com>
Date: Mon, 17 Feb 2003 13:33:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Osamu Tomita <tomita@cinet.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Christoph Hellwig'" <hch@infradead.org>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (16/26) NIC
References: <20030217134333.GA4734@yuzuki.cinet.co.jp> <20030217141552.GP4799@yuzuki.cinet.co.jp> <3E5115BB.6020407@pobox.com> <3E5124AC.80505@didntduck.org>
In-Reply-To: <3E5124AC.80505@didntduck.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> Jeff Garzik wrote:
> 
>>  > -#ifdef __ISAPNP__    > +#if defined(__ISAPNP__) && 
>> !defined(CONFIG_X86_PC9800)
>>
>>
>> I am curious, does PC9800 support ISAPNP at all?
>>
>> Perhaps a dumb question, but I wonder if the above ifdef can be 
>> simplified by turning off ISAPNP on PC9800?
> 
> 
> As long as the machine has ISA expansion slots, ISAPNP is possible.  It 
> is a property of the card, not the system.


I know that, and that still didn't answer my question :)

	Jeff



