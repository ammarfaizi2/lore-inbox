Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVBCQyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVBCQyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 11:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbVBCQuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 11:50:44 -0500
Received: from 67.107.199.112.ptr.us.xo.net ([67.107.199.112]:12279 "EHLO
	hathawaymix.org") by vger.kernel.org with ESMTP id S263173AbVBCQts
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:49:48 -0500
Message-ID: <420257ED.3020002@hathawaymix.org>
Date: Thu, 03 Feb 2005 09:57:17 -0700
From: Shane Hathaway <shane@hathawaymix.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041228
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Configure MTU via kernel DHCP
References: <E1CwfQK-00011a-00@gondolin.me.apana.org.au>
In-Reply-To: <E1CwfQK-00011a-00@gondolin.me.apana.org.au>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Shane Hathaway <shane@hathawaymix.org> wrote:
> 
>>The attached patch enhances the kernel's DHCP client support (in 
>>net/ipv4/ipconfig.c) to set the interface MTU if provided by the DHCP server.  
>>Without this patch, it's difficult to netboot on a network that uses jumbo 
>>frames.  The patch is based on 2.6.10, but I'll update it to the latest 
>>testing kernel if that would expedite its inclusion in the kernel.
> 
> 
> Have you looked at using initramfs and running the DHCP client in
> user space? You'll get a lot more freedom that way.

Hey, that's a good idea.  I'll explore it.

Shane

