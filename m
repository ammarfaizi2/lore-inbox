Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272980AbRIMKel>; Thu, 13 Sep 2001 06:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273069AbRIMKec>; Thu, 13 Sep 2001 06:34:32 -0400
Received: from chfdns02.ch.intel.com ([143.182.246.25]:37312 "EHLO
	melete.ch.intel.com") by vger.kernel.org with ESMTP
	id <S272980AbRIMKeW>; Thu, 13 Sep 2001 06:34:22 -0400
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B2731C@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'David Woodhouse'" <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: RE: find struct pci_dev from struct net_device 
Date: Thu, 13 Sep 2001 13:34:39 +0300
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just trying to repent by contributing something good back to the community
;-)

Actually, I'm using this exact code and in an open source project too (we
have those too you know).

-----Original Message-----
From: David Woodhouse [mailto:dwmw2@infradead.org]
Sent: Thursday, September 13, 2001 12:42 PM
To: Hen, Shmulik
Cc: 'Sebastian Heidl'; linux-kernel@vger.kernel.org
Subject: Re: find struct pci_dev from struct net_device 



shmulik.hen@intel.com said:
> Take the value of dev->base_addr, mask it's lowest 4 bits, do a scan
> of all PCI net devices and in each PCI device try to match to each of
> the 6 address regs: 

We have to assume this isn't a deliberate attempt to mislead, and that you 
really do things like this in your own code.

I suspect that whatever chance there was of someone trying to help out some
poor user unfortunate or ignorant enough to use the binary-only modules that
you are working on has just bitten the dust. 

--
dwmw2

