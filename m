Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVC3KC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVC3KC7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 05:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVC3KC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 05:02:59 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:7758 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261827AbVC3KC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 05:02:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ID/mbcJ7cT0u+r3i5z8wu78X7euj45ERIzMqDPBbH5weor69noP3o8afmcbp+UKmZhkFZildMtwMt+NXCqY0vN0yDjNWmnxaEQDSac2v4j0VShcl4kYcdzLbfZWPJkI05IQRwQMH0xkYj92f0IBFAC3A1tUh+4vcZwZIbPW1UOs=
Message-ID: <aec7e5c30503300202446ac0e1@mail.gmail.com>
Date: Wed, 30 Mar 2005 12:02:54 +0200
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Ron Gage <ron@rongage.org>
Subject: Re: Continuing woes - Yenta PCMCIA and USB 2.0 Cardbus Card
Cc: linux-kernel@vger.kernel.org, daniel.ritz@gmx.ch, jonas.oreland@mysql.com
In-Reply-To: <200503291906.19890.ron@rongage.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <200503291906.19890.ron@rongage.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 29 Mar 2005 19:06:19 -0500, Ron Gage <ron@rongage.org> wrote:
> Laptop is an HP Pavilion N5150, Intel USB chipset (UHCI).  Cardbus card is
> generic ALI based USB chipset (EHCI/OHCI).  USB drive is a Sony VAIO external
> case for a 2.5" drive.  The chip in the usb drive has no manufacturer
> markings on it, just the following character sequences: CS881BAG, 0451B0C104,
> 107

I've got an external 2.5" VAIO case (VAIO original yeah, right)  that
works ok what I can tell with USB2 on my laptop. Are the id:s below
the same as yours?

T:  Bus=04 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  8 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=04cf ProdID=8818 Rev=b0.07
S:  Manufacturer=Myson Century, Inc.
S:  Product=USB Mass Storage Device
S:  SerialNumber=100
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr= 10mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=05 Prot=50 Driver=usb-storage
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

The 2.5" case also works with USB 1.1, but it is kind of funky. I
guess it requires lots of power. So much power that I have to use a
hub with external power to connect it to a winxp laptop. Connecting it
directly to the laptop does not work for some strange reason - MANY
other devices are powered directly from that laptop.

I recently realized that there are no firewire pccards on the market
today that can power my firewire-powered cd-burner without using an
external ac adapter. My Apple G4 Mac can power the darn thing over
firewire though. Maybe the same thing goes for USB2 host controllers
on pccard? Maybe you need an external ac adapter?

/ magnus
