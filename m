Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267890AbRHFKzM>; Mon, 6 Aug 2001 06:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267892AbRHFKzC>; Mon, 6 Aug 2001 06:55:02 -0400
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:25351 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S267890AbRHFKyt>; Mon, 6 Aug 2001 06:54:49 -0400
Date: Mon, 6 Aug 2001 12:54:58 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8-pre4, lots of compile warnings 
In-Reply-To: <3334.997091551@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.33.0108061155480.8689-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001, Keith Owens wrote:

> Add attribute unused plus a BIG comment saying that the code should be
> moved to the new pci infrastructure ASAP.  Add the code to the janitor
> list.

Moving to the new pci infrastructure is not an option for the
drivers/isdn/hisax driver. For historical reasons, it doesn't use
autoprobing, changing that now will break initializiation on probably
every distribution out there (if it supports ISDN). I'll break this
compatibility in 2.5, though.

I think the drivers/isdn/avmb1 drivers can be fixed, I'll take care of 
that.

--Kai



