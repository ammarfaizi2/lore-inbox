Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129364AbRCBR6D>; Fri, 2 Mar 2001 12:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129372AbRCBR5x>; Fri, 2 Mar 2001 12:57:53 -0500
Received: from [62.172.234.2] ([62.172.234.2]:41871 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129364AbRCBR5p>;
	Fri, 2 Mar 2001 12:57:45 -0500
Date: Fri, 2 Mar 2001 17:56:58 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac7
In-Reply-To: <E14Ystf-0001vP-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0103021749240.738-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, Alan Cox wrote:
> 	[24940903.pdf]
> 	Table 14 in paticular gives the config bits

ok, thank you. Now I understand (maybe) whats' going on. Linux treated
bits 22,23,24,25 but ignored 27 which it shouldn't have. Now, coupled with
the fact that the problematic box I have (Celeron) has that bit 27 set 
suggests that we ought to extend mult[] table appropriately. The values
for that Celeron do not match anything in the Table 14 so we have to
extend mult[] emprirically. (so I now come back to the idea of 4bit
representation of 'bus').

I will stop here/now but I will definitely come back to this interesting
problem in 24 hours. But if anyone fixes it before then, I won't cry :)
Of course, before sending anything I will make sure my patch works on
_all_ my machines without any exceptions.

Regards,
Tigran

