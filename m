Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSIDXMH>; Wed, 4 Sep 2002 19:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSIDXMH>; Wed, 4 Sep 2002 19:12:07 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:2294 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316088AbSIDXMH>; Wed, 4 Sep 2002 19:12:07 -0400
Subject: Re: TCP Segmentation Offloading (TSO)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gabriel Paubert <paubert@iram.es>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0209050027270.7673-100000@gra-lx1.iram.es>
References: <Pine.LNX.4.33.0209050027270.7673-100000@gra-lx1.iram.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 05 Sep 2002 00:17:18 +0100
Message-Id: <1031181438.3017.125.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 23:39, Gabriel Paubert wrote:
> While it would work, this sequence is overkill. Unless I'm mistaken, the
> only property of bswap which is used in this case is that it swaps even
> and odd bytes, which can be done by a simple "roll $8,%eax" (or rorl).

bswap is a 32bit swap. 
