Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVBCL6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVBCL6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbVBCLtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:49:50 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:24325 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262634AbVBCLpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:45:52 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: shane@hathawaymix.org (Shane Hathaway)
Subject: Re: [PATCH] Configure MTU via kernel DHCP
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <200502022148.00045.shane@hathawaymix.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CwfQK-00011a-00@gondolin.me.apana.org.au>
Date: Thu, 03 Feb 2005 22:45:24 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shane Hathaway <shane@hathawaymix.org> wrote:
> 
> The attached patch enhances the kernel's DHCP client support (in 
> net/ipv4/ipconfig.c) to set the interface MTU if provided by the DHCP server.  
> Without this patch, it's difficult to netboot on a network that uses jumbo 
> frames.  The patch is based on 2.6.10, but I'll update it to the latest 
> testing kernel if that would expedite its inclusion in the kernel.

Have you looked at using initramfs and running the DHCP client in
user space? You'll get a lot more freedom that way.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
