Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129311AbRCBQ4V>; Fri, 2 Mar 2001 11:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129318AbRCBQ4N>; Fri, 2 Mar 2001 11:56:13 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26630 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129311AbRCBQ4F>; Fri, 2 Mar 2001 11:56:05 -0500
Subject: Re: Linux 2.4.2ac7
To: tigran@veritas.com (Tigran Aivazian)
Date: Fri, 2 Mar 2001 16:59:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0103021638260.6279-100000@penguin.homenet> from "Tigran Aivazian" at Mar 02, 2001 04:46:40 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Ystf-0001vP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the bad news to this "rule" is that I just found one "exception". Namely,
> I have Celeron-600/100 and PentiumII-333/66 and both evaluate to
> bus/mul=0/0 even in 4bit bus representation which is impossible. So, this
> is my big stumbling block.... if you tell me how to overcome
> this, I can very quickly build buscode[] table that works on all other
> machines I have.
> 
> also, a pointer to anything written down about bus encoding in 2E MSR
> would be nice.

Cyrix III samuel data book
Mobile Intel(R) Pentium III Processor in BGA2 and ,,
	[24940903.pdf]
	Table 14 in paticular gives the config bits

This also implies a bus selection table of
	00	66MHz
	01	100Mhz
	10	Reserved
	11	133 Mhz


