Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261776AbSIXUG5>; Tue, 24 Sep 2002 16:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261781AbSIXUG5>; Tue, 24 Sep 2002 16:06:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38159 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261776AbSIXUG4>;
	Tue, 24 Sep 2002 16:06:56 -0400
Message-ID: <3D90C6FB.4000008@pobox.com>
Date: Tue, 24 Sep 2002 16:11:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: erik@hensema.xs4all.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: via-rhine, VT6103 and VT8235
References: <JOGPEBMEIODLJAAA@mailcity.com> <20020923210112.GA423@k3.hellgate.ch> <slrnap1go1.1nc.usenet@bender.home.hensema.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Hensema wrote:
> And this is 2.4.18-4GB (SuSE 8.0 standard kernel):
> 
> | via-rhine.c:v1.10-LK1.1.13  Nov-17-2001  Written by Donald Becker
> |   http://www.scyld.com/network/via-rhine.html
> | PCI: Found IRQ 11 for device 00:0d.0
> | eth0: VIA VT6105 Rhine-III at 0xcc00, 00:40:f4:5f:94:d6, IRQ 11.
> | eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
> | eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
> 
> Note that I've got local APIC support compiled in on the 2.4.20 kernel.
> Could this be the cause of the problem?


it's certainly possible... try compiling the support out of the kernel 
or booting with "noapic"...

	Jeff



