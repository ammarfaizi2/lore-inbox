Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266497AbSLDNDl>; Wed, 4 Dec 2002 08:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266507AbSLDNDl>; Wed, 4 Dec 2002 08:03:41 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:56228 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266497AbSLDNDj>; Wed, 4 Dec 2002 08:03:39 -0500
Subject: Re: stock 2.4.20: loading amd76x_pm makes time jiggle on A7M266-D
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kay Diederichs <kay.diederichs@uni-konstanz.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DEDF543.51C80677@uni-konstanz.de>
References: <3DEDF543.51C80677@uni-konstanz.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 13:45:31 +0000
Message-Id: <1039009531.15353.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-04 at 12:29, Kay Diederichs wrote:
> the subject says it all: 
> 
> if I use the powersaving module amd76x_pm then the time is not kept. The
> hardware is Asus A7M266-D with 2 MP1900 processors, BIOS is 1004 (but I
> tried later BIOS versions as well).

Boot with "notsc". Unfortunately I dont think there is a way I can make
the module turn off tsc at runtime.

