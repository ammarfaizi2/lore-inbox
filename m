Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbTBQQxU>; Mon, 17 Feb 2003 11:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbTBQQxU>; Mon, 17 Feb 2003 11:53:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22539 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267163AbTBQQxT>;
	Mon, 17 Feb 2003 11:53:19 -0500
Message-ID: <3E5115BB.6020407@pobox.com>
Date: Mon, 17 Feb 2003 12:02:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Osamu Tomita <tomita@cinet.co.jp>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Christoph Hellwig'" <hch@infradead.org>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (16/26) NIC
References: <20030217134333.GA4734@yuzuki.cinet.co.jp> <20030217141552.GP4799@yuzuki.cinet.co.jp>
In-Reply-To: <20030217141552.GP4799@yuzuki.cinet.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > -#ifdef __ISAPNP__	
 > +#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)


I am curious, does PC9800 support ISAPNP at all?

Perhaps a dumb question, but I wonder if the above ifdef can be 
simplified by turning off ISAPNP on PC9800?

