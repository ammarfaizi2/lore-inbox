Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318736AbSHANOZ>; Thu, 1 Aug 2002 09:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318737AbSHANOZ>; Thu, 1 Aug 2002 09:14:25 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:14575 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318736AbSHANOY>; Thu, 1 Aug 2002 09:14:24 -0400
Subject: Re: Kernel panic on Dual Athlon MP
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lars Schmitt <lschmitt@e18.physik.tu-muenchen.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208011224.g71COrW05657@pc02.e18.physik.tu-muenchen.de>
References: <200208011224.g71COrW05657@pc02.e18.physik.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 15:33:44 +0100
Message-Id: <1028212424.14865.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 13:24, Lars Schmitt wrote:
> > On 2002-03-15 18:54:24 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >> Some gige cards don't seem to work with some dual athlon bioses. Other than
> >> that it should be fine
> 
> Could you specify that a bit more? In particular, am I likely to
> have such an unlucky combination? Would a BIOS upgrade help or
> should I get a different GigE card?

My board won't even POST with a tg3 card in it. With a newer BIOS it
passes the POST test and seems to work with the kernel fixups for the 
PCI bridges. There are also multiple people who had 3ware problems with
very fast machines, but I gather the latest driver merge fixed that.

So 2.4.9 I'd certainly expect to fail dismally. 2.4.18 ought to be ok as
should 2.4.19rc4. I run my board with an aacraid scsi and with netgear
ethernet and its stable. 

Alan

