Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRAYTlW>; Thu, 25 Jan 2001 14:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRAYTlM>; Thu, 25 Jan 2001 14:41:12 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:21519 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129051AbRAYTkz>;
	Thu, 25 Jan 2001 14:40:55 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101251940.WAA10110@ms2.inr.ac.ru>
Subject: Re: [UPDATE] Zerocopy, last one today I promise :-)
To: davem@redhat.COM (David S. Miller)
Date: Thu, 25 Jan 2001 22:40:40 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <14960.22256.322768.447815@pizda.ninka.net> from "David S. Miller" at Jan 25, 1 07:45:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>  > What exaclty were the issues with the intel cards and sg+csum?
>  > 
>  > Any idea how much work it'd require to surmount them?
> 
> Getting Intel to release full specs on how to make use of
> TX hardware checksum assist with the eepro100.

It simply does not exist for 82559* in all the steppings.
eepro100 is pretty poor device.

Probably, it exists for card identified as Gamla (D102) (82559 is D101).

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
