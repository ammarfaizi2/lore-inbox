Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUEXCsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUEXCsX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 22:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbUEXCsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 22:48:22 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:19469 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263769AbUEXCsV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 22:48:21 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: bgerst@didntduck.org (Brian Gerst)
Subject: Re: i486 emu in mainline?
Cc: willy@w.ods.org, arjanv@redhat.com, hch@lst.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <40B0DB49.3090308@quark.didntduck.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BS5V8-0006d6-00@gondolin.me.apana.org.au>
Date: Mon, 24 May 2004 12:47:42 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <bgerst@didntduck.org> wrote:
>
>> It was intentional for speed purpose. The areas are checked once with
>> verify_area() when we need to access memory, then data is copied directly
>> from/to memory. I don't think there's any risk, but I can be wrong.
> 
> Which will break with 4G/4G.  You must use at least __get_user().

A 386 with a 4G/4G split, I'd like to see that.
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
