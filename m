Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262181AbSJWLjv>; Wed, 23 Oct 2002 07:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbSJWLjv>; Wed, 23 Oct 2002 07:39:51 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:47038 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262181AbSJWLju>; Wed, 23 Oct 2002 07:39:50 -0400
Subject: Re: [RFC][PATCHSET] PC-9800 architecture (CORE only)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Andrey Panin <pazke@orbita1.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DB5706A.9D3915F0@cinet.co.jp>
References: <20021022065028.GA304@pazke.ipt> 
	<3DB5706A.9D3915F0@cinet.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 13:02:18 +0100
Message-Id: <1035374538.4033.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 16:36, Osamu Tomita wrote:
> IORESOURCE98_SPARSE flag means odd or even only addressing.
> We modify check_region(), request_region() and release_region().
> If length parameter has negative value, addressing is sparse.
> For example,
>  request_region(0x100, -5, "xxx"); gets 0x100, 0x102 and 0x104.

Does PC-9800 ever have devices on 0x100/2/4/8 overlapping another device
on 0x101/103/105 ?

