Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290175AbSAKXzs>; Fri, 11 Jan 2002 18:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290176AbSAKXzj>; Fri, 11 Jan 2002 18:55:39 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:31478 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S290175AbSAKXza>;
	Fri, 11 Jan 2002 18:55:30 -0500
Date: Fri, 11 Jan 2002 15:55:25 -0800
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wavelan_cs update (Pcmcia backport)
Message-ID: <20020111155525.A15627@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020111151825.C15515@bougret.hpl.hp.com> <1563806246.1010792978@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1563806246.1010792978@[195.224.237.69]>; from linux-kernel@alex.org.uk on Fri, Jan 11, 2002 at 11:49:39PM -0000
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 11:49:39PM -0000, Alex Bligh - linux-kernel wrote:
> > 	I was playing with wavelan_cs in the kernel (converting it to
> > the new Wireless Extensions), and I realised that it doesn't work at
> > all. I had a look at the code and it is so antique that it is scary.
> 
> Don't suppose you'd like to backport the non-pcmcia (i.e. true
> PCI, not pcmcia on a PCI minibridge) version too? I will happilly
> test it for you (IBM T23).
> 
> --
> Alex Bligh

	You are confused. I'm talking here of the wavelan_cs driver
for the old (obsolete) Wavelan hardware (non IEEE). Please check the
Wireless Howto for more details.
	For the Wavelan IEEE/Orinoco, the kernel is up-to-date (the
next 2.4.18 should be once Marcelo adds the missing files), and it's
the Pcmcia package that need a backport. For PCI support, the
situation is messy, but we can talk about that off list (or check the
samba archive).
	Regards,

	Jean
