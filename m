Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272951AbRIMJmN>; Thu, 13 Sep 2001 05:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272952AbRIMJmD>; Thu, 13 Sep 2001 05:42:03 -0400
Received: from t2.redhat.com ([199.183.24.243]:1790 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S272951AbRIMJls>; Thu, 13 Sep 2001 05:41:48 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B2731B@hasmsx52.iil.intel.com> 
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B2731B@hasmsx52.iil.intel.com> 
To: "Hen, Shmulik" <shmulik.hen@intel.com>
Cc: "'Sebastian Heidl'" <heidl@zib.de>, linux-kernel@vger.kernel.org
Subject: Re: find struct pci_dev from struct net_device 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Sep 2001 10:41:57 +0100
Message-ID: <7927.1000374117@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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


