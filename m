Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281631AbRKPW6X>; Fri, 16 Nov 2001 17:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281644AbRKPW6T>; Fri, 16 Nov 2001 17:58:19 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:4271 "HELO postfix2-1.free.fr")
	by vger.kernel.org with SMTP id <S281631AbRKPW57> convert rfc822-to-8bit;
	Fri, 16 Nov 2001 17:57:59 -0500
Date: Fri, 16 Nov 2001 21:12:33 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
Cc: <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] block-highmem-all-18
In-Reply-To: <20011116.135409.118971851.davem@redhat.com>
Message-ID: <20011116205140.J2032-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Nov 2001, David S. Miller wrote:

>    From: Gérard Roudier <groudier@free.fr>
>    Date: Fri, 16 Nov 2001 19:59:02 +0100 (CET)
>
>    On Fri, 16 Nov 2001, Jens Axboe wrote:
>
>    > - Add sym2 can_dma_32 flag (me)
>                 ^^^^^^^^^^ Pooaaahhh!:) What's this utter oddity ?
>    Only dma 32 ? :-)
>
> It is workaround for buggy drivers, when set it means that single SG
> list entry request will be handled correctly.  When clear it means
> that single entry SG lists are to be avoided by the block layer.
>
> Many devices would explode when given single entry scatterlist. :(
>
> It's naming is questionable... that I agree with.  The name should be
> more suggestive to what it really means.

For now, it humanly means that the device is able to dma decimal value 32
which does not look this great a feature, nor that serious a bug. :-) :o)

Thanks, anyway, for the clarification.

  Gérard.

