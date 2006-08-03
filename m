Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWHCPSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWHCPSL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWHCPSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:18:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33718 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964772AbWHCPSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:18:10 -0400
Message-ID: <44D213A3.6000009@redhat.com>
Date: Thu, 03 Aug 2006 11:17:55 -0400
From: Rik van Riel <riel@redhat.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Antonio Vargas <windenntw@gmail.com>
CC: Arjan van de Ven <arjan@infradead.org>, Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com>	 <1154603822.2965.18.camel@laptopd505.fenrus.org> <69304d110608030516y16f7d1fdiaccfbe4ecca3084a@mail.gmail.com>
In-Reply-To: <69304d110608030516y16f7d1fdiaccfbe4ecca3084a@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Vargas wrote:

> If the essence of using virtual machines is precisely that the machine
> acts just as if it was a real hardware one, then we should not need
> any modifications to the kernel. So, it would be much better if the
> hypervirsor was completely transparent and just emulated a native cpu
> and a common native set of hardware,

That's not a good idea if you like performance.

Paravirtualization makes a lot of sense.

-- 
All Rights Reversed
