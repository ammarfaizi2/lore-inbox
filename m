Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263324AbUEKSyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUEKSyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 14:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbUEKSyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 14:54:20 -0400
Received: from imap.gmx.net ([213.165.64.20]:47063 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263324AbUEKSyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 14:54:02 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: problem with sis900
Date: Tue, 11 May 2004 21:01:09 +0200
User-Agent: KMail/1.6.2
References: <1084300104.24569.8.camel@datacontrol>
In-Reply-To: <1084300104.24569.8.camel@datacontrol>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405112101.09525.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have problems with sis900 driver too. I can only use the ethernet card in 
half duplex mode. At startup I get following messages:

sis900.c: v1.08.07 11/02/2003
eth0: Unknown PHY transceiver found at address 0.
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Unknown PHY transceiver found at address 2.
eth0: Unknown PHY transceiver found at address 3.
eth0: Unknown PHY transceiver found at address 4.
eth0: Unknown PHY transceiver found at address 5.
eth0: Unknown PHY transceiver found at address 6.
eth0: Unknown PHY transceiver found at address 7.
eth0: Unknown PHY transceiver found at address 8.
eth0: Unknown PHY transceiver found at address 9.
eth0: Unknown PHY transceiver found at address 10.
eth0: Unknown PHY transceiver found at address 11.
eth0: Unknown PHY transceiver found at address 12.
eth0: Unknown PHY transceiver found at address 13.
eth0: Unknown PHY transceiver found at address 14.
eth0: Unknown PHY transceiver found at address 15.
eth0: Unknown PHY transceiver found at address 16.
eth0: Unknown PHY transceiver found at address 17.
eth0: Unknown PHY transceiver found at address 18.
eth0: Unknown PHY transceiver found at address 19.
eth0: Unknown PHY transceiver found at address 20.
eth0: Unknown PHY transceiver found at address 21.
eth0: Unknown PHY transceiver found at address 22.
eth0: Unknown PHY transceiver found at address 23.
eth0: Unknown PHY transceiver found at address 24.
eth0: Unknown PHY transceiver found at address 25.
eth0: Unknown PHY transceiver found at address 26.
eth0: Unknown PHY transceiver found at address 27.
eth0: Unknown PHY transceiver found at address 28.
eth0: Unknown PHY transceiver found at address 29.
eth0: Unknown PHY transceiver found at address 30.
eth0: Unknown PHY transceiver found at address 31.
eth0: Using transceiver found at address 31 as default
eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 19, 00:10:dc:8f:a9:ac.

It's a SiS900 PCI card, and not a Realtek.

greets dominik


On Tuesday 11 May 2004 20:28, mike wrote:
> In kernels 2.6.5 and above (may affect 2.6.4 as well) there seems to be
> a problem with the sis900 eth driver
>
> I have a sis chipset with integrated ethernet sis900 driver which has
> always worked perfectly up to and including 2.6.3 (fedora)
>
> Now with both fedora 2.6.5 kernel and vanilla 2.6.6 eth0 does not come
> up
>
> relevant messages
>
> sis900 device eth0 does not appear to be present delaying initialisation
>
> and from dmesg eth0: cannot find ISA bridge
>
> 2.6.3 works fine
>
> lsmod shows sis and sis900 modules loaded fine
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
