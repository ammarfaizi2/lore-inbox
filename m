Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276505AbRJCQgw>; Wed, 3 Oct 2001 12:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276503AbRJCQgn>; Wed, 3 Oct 2001 12:36:43 -0400
Received: from web14803.mail.yahoo.com ([216.136.224.219]:1802 "HELO
	web14803.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276500AbRJCQgb>; Wed, 3 Oct 2001 12:36:31 -0400
Message-ID: <20011003163700.66539.qmail@web14803.mail.yahoo.com>
Date: Wed, 3 Oct 2001 09:37:00 -0700 (PDT)
From: Linux Bigot <linuxopinion@yahoo.com>
Subject: Re: how to get virtual address from dma address
To: jes@sunsite.dk
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please tell me why can't I use bus_to_virt().

Thanks


-----Original Message-----
From:	Jes Sorensen [SMTP:jes@sunsite.dk]
Sent:	Wednesday, October 03, 2001 11:26 AM
To:	Linux Bigot
Cc:	linux-kernel@vger.kernel.org
Subject:	Re: how to get virtual address from dma
address

>>>>> "Linux" == Linux Bigot <linuxopinion@yahoo.com>
writes:

Linux> All programmers I am relatively new to linux
kernel. Please
Linux> advise what is the safe way to get the original
virtaul address
Linux> from dma address e.g.,

You have to store the address you pass to
pci_map_single() somewhere
in your data structures together with the dma address.

Jes
-
To unsubscribe from this list: send the line
"unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at 
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



__________________________________________________
Do You Yahoo!?
Listen to your Yahoo! Mail messages from any phone.
http://phone.yahoo.com
