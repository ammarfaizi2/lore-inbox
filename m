Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136613AbREGS6y>; Mon, 7 May 2001 14:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136611AbREGS6m>; Mon, 7 May 2001 14:58:42 -0400
Received: from tango.SoftHome.net ([204.144.231.49]:27334 "HELO
	tango.SoftHome.net") by vger.kernel.org with SMTP
	id <S136613AbREGS62>; Mon, 7 May 2001 14:58:28 -0400
Message-ID: <017501c0d728$05177160$7253e59b@megatrends.com>
Reply-To: "Venkatesh Ramamurthy" <venkateshr@ami.com>
From: "Venkatesh Ramamurthy" <venkateshr@softhome.net>
To: "Pekka Pietikainen" <pp@evil.netppl.fi>, <linux-kernel@vger.kernel.org>
In-Reply-To: <E14wlUi-0003WQ-00@the-village.bc.nu> <Pine.LNX.3.95.1010507121212.4256A-100000@chaos.analogic.com> <20010507213048.A17014@netppl.fi>
Subject: Re: [Question] Explanation of zero-copy networking
Date: Mon, 7 May 2001 15:00:43 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then there's the interrupt problem, which someone will have to solve
> before they start shipping 10gigE NICs that use 1500-byte frames, 850000
> interrupts/s without mitigation. Wheeee!!!!

In this situations polling helps rather than interrupt driven IO. When there
is heavy IO(read more interrupts per sec), we should automatically switch to
polling mode, once the IO drops we can go to Interrupt driven. But how do we
decide when to switch modes?

Just my 2 cents .....


