Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266528AbSLDNvm>; Wed, 4 Dec 2002 08:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266548AbSLDNvm>; Wed, 4 Dec 2002 08:51:42 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:18597 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266528AbSLDNvm>; Wed, 4 Dec 2002 08:51:42 -0500
Subject: Re: stock 2.4.20: loading amd76x_pm makes time jiggle on A7M266-D
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pedro Larroy <piotr@omega.resa.es>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021204132235.GA32090@omega.resa.es>
References: <3DEDF543.51C80677@uni-konstanz.de>
	<1039009531.15353.13.camel@irongate.swansea.linux.org.uk> 
	<20021204132235.GA32090@omega.resa.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 14:33:14 +0000
Message-Id: <1039012394.15359.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-04 at 13:22, Pedro Larroy wrote:
> I've had the same issues and a lot of overruns in eth0 plus bandwith
> decreased to one tenth. Does this happen because disconnecting the athlon
> FSB makes impossible for the ethernet interface to perform dma on memory?

The system has to wake back up at that point. There are some tunables in
the module if you want to play

