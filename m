Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131891AbRBDP4h>; Sun, 4 Feb 2001 10:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131958AbRBDP42>; Sun, 4 Feb 2001 10:56:28 -0500
Received: from colorfullife.com ([216.156.138.34]:2308 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131891AbRBDP4P>;
	Sun, 4 Feb 2001 10:56:15 -0500
Message-ID: <3A7D7B9D.9785603F@colorfullife.com>
Date: Sun, 04 Feb 2001 16:56:13 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Hen, Shmulik" <shmulik.hen@intel.com>
CC: "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Re: kernel memory allocations alignment
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27119@hasmsx52.iil.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hen, Shmulik" wrote:
> 
> When using kmalloc(size_t size), do I get a guaranty that the memory region
> allocated is aligned according to the size specified ?
> More to the point, if I call kmalloc for type int on an IA64 architecture is
> the pointer going to be 8 bytes aligned ?
>

Yes, kmalloc results are always 'sizeof(void*)' aligned.

Do you have stricter alignment requirements?

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
