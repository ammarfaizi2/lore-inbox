Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272095AbRHVVkr>; Wed, 22 Aug 2001 17:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272129AbRHVVkh>; Wed, 22 Aug 2001 17:40:37 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:59909 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S272095AbRHVVk2>; Wed, 22 Aug 2001 17:40:28 -0400
Message-Id: <200108222140.f7MLeUY17166@aslan.scsiguy.com>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
cc: "David S. Miller" <davem@redhat.com>, axboe@suse.de, skraw@ithnet.com,
        phillips@bonn-fries.net, linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
In-Reply-To: Your message of "Wed, 22 Aug 2001 23:07:47 +0200."
             <20010822223658.X932-100000@gerard> 
Date: Wed, 22 Aug 2001 15:40:30 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I seem to understand that Justin's is referring to the DMA related API of
>BSD O/Ses that, I believe, originates from NetBSD.

Not really.  I just don't think that having both a 32bit and a 64bit
type for dma_addr_t makes sense.  I'm not advocating all devices perform
DAC.

I've started looking through the network devices for bloat caused
by the change in size of this type and I haven't found it anywhere.

--
Justin
