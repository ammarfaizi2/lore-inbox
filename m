Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270556AbRHITR4>; Thu, 9 Aug 2001 15:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270559AbRHITRr>; Thu, 9 Aug 2001 15:17:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54791 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270556AbRHITR0>; Thu, 9 Aug 2001 15:17:26 -0400
Subject: Re: struct page to 36 (or 64) bit bus address?
To: johannes@erdfelt.com (Johannes Erdfelt)
Date: Thu, 9 Aug 2001 20:19:46 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010809151022.C1575@sventech.com> from "Johannes Erdfelt" at Aug 09, 2001 03:10:22 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UvLO-0007tH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately the PCI DMA API on i386 will only return 32 bit addresses,
> which kinda defeats the purpose of what I'm doing.

For the short term

> Obviously the more portable way across architectures is using the PCI
> DMA API but when will the implementation be fixed so I can use it to
> exploit the full potential of this device?

2.5 I believe, ping the peacefrog and ask <DaveM@redhat.com>
