Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287417AbSATA64>; Sat, 19 Jan 2002 19:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287828AbSATA6q>; Sat, 19 Jan 2002 19:58:46 -0500
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:57604 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S287417AbSATA6c>;
	Sat, 19 Jan 2002 19:58:32 -0500
Date: Sat, 19 Jan 2002 19:58:29 -0500 (EST)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: Andre Hedrick <andre@linuxdiskcert.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Andre's IDE Patch (1/7)
In-Reply-To: <Pine.LNX.4.10.10201191625110.9354-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.33.0201191955210.14950-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 19 Jan 2002, Andre Hedrick wrote:

>
> Please don't do that.  There is a fatal flaw in those patches we all
> observed in 2.5.3pre1.  I have 2.4.16 as a possible candidate and
> auto-patching for 2.4.17 at the moment.

On Wed, 16 Jan 2002, Andre Hedrick wrote:
> If the driver falls out of DMA, DEADBOX!!!!
> There is a conflict of BIO and ACB and it is very fatal.

It was my impression that the problem with 2.5.3-pre1 was a complication
that existed only because of bio in 2.5.  Oops.  I assume this means then
that all of us running your ide.2.4.16.12102001.patch should immediately
revert so Bad Things don't happen?

Regards,
Rob Radez

