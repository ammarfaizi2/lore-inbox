Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131588AbRDPOWs>; Mon, 16 Apr 2001 10:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131672AbRDPOWi>; Mon, 16 Apr 2001 10:22:38 -0400
Received: from tango.SoftHome.net ([204.144.231.49]:6074 "HELO
	tango.SoftHome.net") by vger.kernel.org with SMTP
	id <S131588AbRDPOW0>; Mon, 16 Apr 2001 10:22:26 -0400
Message-ID: <0c4e01c0c681$00b5d010$7253e59b@megatrends.com>
From: "Venkatesh Ramamurthy" <venkateshr@softhome.net>
To: "Jes Sorensen" <jes@linuxcare.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        <peterj@ami.com>
Cc: <modica@sgi.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3AD601B4.7E0B14E4@sgi.com> <3AD604B0.2713F08B@mandrakesoft.com> <d3vgo9ej5r.fsf@lxplus015.cern.ch> <3AD7A6ED.7626BE05@mandrakesoft.com>
Subject: Re: Proposal for a new PCI function call
Date: Mon, 16 Apr 2001 10:24:51 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems to me that not doing #ifdef CONFIG_HIGHMEM right now is a
> bug...  I think it's the megaraid driver that wants to set dma_addr_t to
> a 64-bit mask.

MegaRAID driver:
Only if the flag __LP64__ is defined, a 64 bit mask is set , otherwise only
a 32 bit mask is used instead. However check for CONFIG_HIGHMEM needs to be
done.




