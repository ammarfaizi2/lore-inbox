Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265483AbSJXPPq>; Thu, 24 Oct 2002 11:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbSJXPPp>; Thu, 24 Oct 2002 11:15:45 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:61379 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265483AbSJXPPp>; Thu, 24 Oct 2002 11:15:45 -0400
Subject: Re: [PATCH] New ARPHRD types
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Solomon Peachy <solomon@linux-wlan.com>
Cc: "David S. Miller" <davem@rth.ninka.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021024145822.GA11876@linux-wlan.com>
References: <20021021221936.GA32390@linux-wlan.com>
	<1035330936.16084.23.camel@rth.ninka.net>
	<20021023141651.GA6644@linux-wlan.com>
	<1035433080.9629.8.camel@rth.ninka.net> 
	<20021024145822.GA11876@linux-wlan.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Oct 2002 16:38:56 +0100
Message-Id: <1035473936.9867.60.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 15:58, Solomon Peachy wrote:
> 1) audit the use of hard_header_len in net/* and submit fixes

We've handled variable length headers for years so that bit I do trust.
AX.25 even has variable length headers on ARP frames 8)

> 2) write an 802.11 equivalent of the code in eth.c

That may be much cleaner and easier to get right. Its also easier to
maintain


