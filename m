Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289061AbSAUFuA>; Mon, 21 Jan 2002 00:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289051AbSAUFrZ>; Mon, 21 Jan 2002 00:47:25 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43535
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289053AbSAUFqy>; Mon, 21 Jan 2002 00:46:54 -0500
Date: Sat, 19 Jan 2002 17:44:08 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Rob Radez <rob@osinvestor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Andre's IDE Patch (1/7)
In-Reply-To: <Pine.LNX.4.33.0201191955210.14950-100000@pita.lan>
Message-ID: <Pine.LNX.4.10.10201191743080.9354-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No but if you miss a one liner stub that bit me in the 2.5.3, you will
have the problems of 2.5.3.


On Sat, 19 Jan 2002, Rob Radez wrote:

> 
> On Sat, 19 Jan 2002, Andre Hedrick wrote:
> 
> >
> > Please don't do that.  There is a fatal flaw in those patches we all
> > observed in 2.5.3pre1.  I have 2.4.16 as a possible candidate and
> > auto-patching for 2.4.17 at the moment.
> 
> On Wed, 16 Jan 2002, Andre Hedrick wrote:
> > If the driver falls out of DMA, DEADBOX!!!!
> > There is a conflict of BIO and ACB and it is very fatal.
> 
> It was my impression that the problem with 2.5.3-pre1 was a complication
> that existed only because of bio in 2.5.  Oops.  I assume this means then
> that all of us running your ide.2.4.16.12102001.patch should immediately
> revert so Bad Things don't happen?
> 
> Regards,
> Rob Radez
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

