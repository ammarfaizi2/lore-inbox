Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317135AbSFKPcV>; Tue, 11 Jun 2002 11:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317139AbSFKPcU>; Tue, 11 Jun 2002 11:32:20 -0400
Received: from [212.176.239.134] ([212.176.239.134]:26240 "EHLO
	vzhik.octet.spb.ru") by vger.kernel.org with ESMTP
	id <S317135AbSFKPcT>; Tue, 11 Jun 2002 11:32:19 -0400
Message-ID: <002101c2115d$1c0bc7c0$baefb0d4@nick>
Reply-To: "Nick Evgeniev" <nick@octet.spb.ru>
From: "Nick Evgeniev" <nick@octet.com>
To: "Andre Hedrick" <andre@linux-ide.org>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10206081251300.1190-100000@master.linux-ide.org>
Subject: Re: linux 2.4.19-preX IDE bugs
Date: Tue, 11 Jun 2002 19:31:48 +0400
Organization: Octet Corp.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Scanner: exiscan *17Hncd-00042Z-00*crV/vZgUgfg* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > I added it to the collection of IDE oddities I'm looking at. There are
> > also some promise requested changes due to get merged at the end of this
> > week. Then we can see where we stand
>
> Also, it is hard to answer email without connectivity in the air.

Agreed. But all what I see is that STABLE Linux kernel DOESN'T has working
driver for promise controller (including latest ac patches) for SEVERAL
MONTHS.
And as for now there is no any progress in fixing it. I don't blame on you,
or Alan,
or whoever else. All I have to suggest is to drop promise support in stable
kernel,
then rewrite/fix it in 2.5 tree... and then backport it to 2.4.

I don't want to make experiments in production environment anymore... And
it's
unfair to the rest of Linux users to keep broken drivers in stable kernel...
Because
nobody expects that stable kernel will rip your fs _daily_.



