Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbSKETiw>; Tue, 5 Nov 2002 14:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265165AbSKETiw>; Tue, 5 Nov 2002 14:38:52 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:51349 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265134AbSKETiu>; Tue, 5 Nov 2002 14:38:50 -0500
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: Willy Tarreau <willy@w.ods.org>, Jim Paris <jim@jtan.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1021105141917.604A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1021105141917.604A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 20:07:26 +0000
Message-Id: <1036526846.6750.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 19:29, Richard B. Johnson wrote:
> The only hardware a modern PC needs to use "slow-down_io" on is
> the RTC CMOS device. Since we need to support older boards, you
> don't want to remove the _p options indiscriminately, but you do
> not want them ever between two consecutive writes to the same device-
> port.

I own at least one that needs the _p on the DMA controller and at one
that needs _p on the PIT


