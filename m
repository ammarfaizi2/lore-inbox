Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbRGYDJL>; Tue, 24 Jul 2001 23:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266500AbRGYDJB>; Tue, 24 Jul 2001 23:09:01 -0400
Received: from pc7.prs.nunet.net ([199.249.167.77]:11272 "HELO
	pc7.prs.nunet.net") by vger.kernel.org with SMTP id <S266488AbRGYDIt>;
	Tue, 24 Jul 2001 23:08:49 -0400
Message-ID: <20010725030855.696.qmail@pc7.prs.nunet.net>
From: "Rico Tudor" <"rico-linux-kernel@patrec.com"@patrec.com>
Subject: Re: DMA problem (?) w/ 2.4.6-xfs and ServerWorks OSB4 Chipset
To: adam-dated-996283107.318d97@flounder.net (Adam McKenna)
Date: Tue, 24 Jul 101 22:08:55 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010724182512.B4614@flounder.net> from "Adam McKenna" at Jul 24, 1 06:25:12 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

ServerWorks OSB4 locks solid if I access both IDE channels, and either
one has DMA enabled.  Current solutions: (i) abandon second channel,
(ii) use PIO, (iii) add Promise card, (iv) add 3ware card.

My machines use (i), (iii), and (iv).  I didn't test two devices on the
same channel, e.g. /dev/hd[ab]
