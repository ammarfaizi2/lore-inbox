Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbUKEBuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbUKEBuI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbUKEBsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 20:48:31 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:47592 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262525AbUKEBrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 20:47:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=PXcl+0YjMWvL9ZHMa9CFmo3sjRuLRGpiHNmMKsUBaYYlvbtdOLp2gV6xHc3cwnRaA+SJFQM5xIQrC5xQ294o2zGgOxujEQzB/ljR6zTWoDsFLLIc791QHBMIB6bQ0rs1tr9W0EPZVE+b+Fhp75TzTB+wrqF34Cl1zOzrIdZ+mgs=
Message-ID: <5786143704110417471fdea461@mail.gmail.com>
Date: Thu, 4 Nov 2004 19:47:13 -0600
From: Jesus Delgado <jdelgado@gmail.com>
Reply-To: Jesus Delgado <jdelgado@gmail.com>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Re: [2.6.10-rc1-mm2] keyboard / synaptics not working
Cc: linux-kernel@vger.kernel.org, matthieu castet <castet.matthieu@free.fr>
In-Reply-To: <5786143704110107302e1722d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410311903.06927@zodiac.zodiac.dnsalias.org>
	 <5786143704110107302e1722d8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:
Iam apply the patchs : pnpacpi and i8042_pnp and my emachines working
againg the mouse and keyboard good.

Thanks

On Mon, 1 Nov 2004 09:30:13 -0600, Jesus Delgado <jdelgado@gmail.com> wrote:
> Hi all:
> 
>     Iam have is the same problems, kernel 2.6.10-rc1 keryboard and
> mouse OK ( emachines M6709), both running kernel 2.6.10-rc1-mm2 the
> keyboard and mouse NOT WORKING.
> 
>   anex my file dsdt.hex.gz
> 
> Helpme please.
> 
> 
> 
> On Sun, 31 Oct 2004 19:03:06 +0100, Alexander Gran
> <alex@zodiac.dnsalias.org> wrote:
> > Hi,
> >
> > using 2.6.10-rc1-mm2 my keyboard and synaptics do not work. 2.6.9-rc4-mm1 is
> > fine. Both bootlogs are attached.
> > lspci (using 2.6.8-rc3-mm1)  gives
> > 0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev
> > 03)
> > 0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev
> > 03)
> > 0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
> > USB UHCI Controller #1 (rev 01)
> > 0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
> > USB UHCI Controller #2 (rev 01)
> > 0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
> > USB UHCI Controller #3 (rev 01)
> > 0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0
> > EHCI Controller (rev 01)
> > 0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81)
> > 0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev
> > 01)
> > 0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage
> > Controller (rev 01)
> > 0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus
> > Controller (rev 01)
> > 0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
> > (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
> > 0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97
> > Modem Controller (rev 01)
> > 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf
> > [Radeon Mobility 9000 M9] (rev 02)
> > 0000:02:00.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus
> > Controller (rev 01)
> > 0000:02:00.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus
> > Controller (rev 01)
> > 0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet
> > Controller (Mobile) (rev 03)
> > 0000:02:02.0 Ethernet controller: Atheros Communications, Inc. AR5211 802.11ab
> > NIC (rev 01)
> >
> > The 2.6.10-rc1-mm2 config is attached,too.
> >
> > regards
> > Alex
> >
> > --
> > Encrypted Mails welcome.
> > PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
> >
> >
> >
> 
> 
>
