Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317984AbSGaMXb>; Wed, 31 Jul 2002 08:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317996AbSGaMXb>; Wed, 31 Jul 2002 08:23:31 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:33781 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317984AbSGaMXb>; Wed, 31 Jul 2002 08:23:31 -0400
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: blp@cs.stanford.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87znw8anje.fsf@pfaff.Stanford.EDU>
References: <Pine.LNX.4.33.0207301433480.2051-100000@penguin.transmeta.com>
	<Pine.GSO.4.21.0207301738090.6010-100000@weyl.math.psu.edu> 
	<87znw8anje.fsf@pfaff.Stanford.EDU>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 31 Jul 2002 14:42:58 +0100
Message-Id: <1028122978.8510.59.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-30 at 22:55, Ben Pfaff wrote:
> 1    The typedef name intN_t designates a signed integer type with
>      width N, no padding bits, and a two's complement
>      representation. Thus, int8_t denotes a signed integer type
>      with a width of exactly 8 bits.

And arbitary alignment requirements. At least I see nothing in C99
saying that

	uint8_t foo;
	uint8_t bar;

isnt allowed to give you interesting suprises


