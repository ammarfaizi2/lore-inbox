Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311424AbSCWXwe>; Sat, 23 Mar 2002 18:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311425AbSCWXwY>; Sat, 23 Mar 2002 18:52:24 -0500
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:30900 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S311424AbSCWXwN>; Sat, 23 Mar 2002 18:52:13 -0500
Date: Sun, 24 Mar 2002 00:52:05 +0100 (CET)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: David Eduardo Gomez Noguera <davidgn@servidor.unam.mx>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CNet Fast Etherenet (Davicom DM9102AF)
In-Reply-To: <20020323125942.13354efa.davidgn@servidor.unam.mx>
Message-ID: <Pine.LNX.4.44.0203240036210.7457-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2002, David Eduardo Gomez Noguera wrote:

> Hello.
> I have just got this card.
> On the 3 1/2 diskette there is code for the module. these two files:
> dm9xs.c  dmfe.c
> but the linux kernel 2.4.17 has got dmfe.c only.

The version in the kernel is based on the latest dm9xs.c driver, but is 
called dmfe.c.  I have no idea why Davicom decided to rename the driver 
for 2.4.

> The files that came with the card are said to be for 2.4 and 2.2
> respectively.

Correct.  

> How does the dmfe.c from the latest kernel differs from the ones that
> come with the card? and which should I stick with?

The version in the kernel is based on the latest dm9xs.c driver, but
contains some fixes that are not present in Davicom's driver.  I recommend
using the one included with the Linux kernel.

As Alan mentioned, you can also use the tulip driver with this card since
it is (yet) a(nother) tulip clone.  With your card you will probably get
better tx performance using the tulip driver at the moment.

/Tobias

