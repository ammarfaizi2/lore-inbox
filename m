Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVEPVUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVEPVUT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVEPVS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:18:27 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:16409 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261904AbVEPVP5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:15:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PISeF4c65cfZAjmlmjdRCTQ4EAxkXSiGj+yDAaXoav1ytV1bQELlU8TMzKtVv9rsx1xlpHYoyw94+mYftWwi0/D79ltNFVw56Qt4KgRivqhQb/2vmeew7M/WPQWhBKg9DY31Jp65SS06twlKj0Yk9/E1nv2kGIwEkaFU1+GtcS8=
Message-ID: <2cd57c90050516141533e30621@mail.gmail.com>
Date: Tue, 17 May 2005 05:15:57 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: 2.6.12-rc4-mm2 build failure in slab.c
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <734040000.1116277074@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <734040000.1116277074@flay>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/05, Martin J. Bligh <mbligh@mbligh.org> wrote:
> mm/slab.c:281: field `entry' has incomplete type
> mm/slab.c: In function `cache_alloc_refill':
> mm/slab.c:2497: warning: control reaches end of non-void function
> mm/slab.c: In function `kmem_cache_alloc':
> mm/slab.c:2567: warning: `objp' might be used uninitialized in this function
> mm/slab.c: In function `__kmalloc':
> mm/slab.c:2567: warning: `objp' might be used uninitialized in this function
> make[1]: *** [mm/slab.o] Error 1
> make[1]: *** Waiting for unfinished jobs....

What's your gcc version?

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
