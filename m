Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288955AbSBDNMz>; Mon, 4 Feb 2002 08:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288956AbSBDNMo>; Mon, 4 Feb 2002 08:12:44 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:47621 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S288955AbSBDNMf>; Mon, 4 Feb 2002 08:12:35 -0500
Message-Id: <200202041311.g14DB2t12901@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Oliver Feiler <kiza@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: fixup descriptions in pci-pc.c
Date: Mon, 4 Feb 2002 15:11:03 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020203152913.A533@gmx.net>
In-Reply-To: <20020203152913.A533@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 February 2002 12:29, Oliver Feiler wrote:
> Ok, this is just a cosmetic thing, but I see that in 2.5.3 the printk
> text in pci_fixup_via_northbridge_bug in pci-pc.c was changed
>
> - printk("Trying to stomp on VIA Northbridge bug...\n");
> + printk("Disabling broken memory write queue.\n");
>
> 	Can't we change this to some meaningful output in 2.4.18 as well? It's
> still the old text with pre7.

Probably. + [reg]: old->new or similar
--
vda
