Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281411AbRKZCW5>; Sun, 25 Nov 2001 21:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281415AbRKZCWr>; Sun, 25 Nov 2001 21:22:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14610 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281411AbRKZCWa>; Sun, 25 Nov 2001 21:22:30 -0500
Message-ID: <3C01A75C.3030500@zytor.com>
Date: Sun, 25 Nov 2001 18:22:20 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-final drivers/net/bonding.c includes user space headers
In-Reply-To: <1595.1006741190@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

> 
> We already have include/linux/limits.h that is included by filesystem
> code.  If anybody needs additional #defines, they can go in our version
> of limits.h instead of trying to use the gcc version.
> 

I guess.  I don't like the idea of not using the compiler-provided 
headers, since it seems to me to make it harder to deal properly with 
gcc changes, though...

	-hpa

