Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269787AbRIMMKZ>; Thu, 13 Sep 2001 08:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269796AbRIMMKQ>; Thu, 13 Sep 2001 08:10:16 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:56520 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S269787AbRIMMKD>;
	Thu, 13 Sep 2001 08:10:03 -0400
Date: Thu, 13 Sep 2001 14:10:24 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Sebastian Heidl <heidl@zib.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: find struct pci_dev from struct net_device
Message-ID: <20010913141024.A24905@se1.cogenit.fr>
In-Reply-To: <20010912145242.C20089@csr-pc1.zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010912145242.C20089@csr-pc1.zib.de>; from heidl@zib.de on Wed, Sep 12, 2001 at 02:52:42PM +0200
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Heidl <heidl@zib.de> :
> What's the easiest way to find a corresponding struct pci_dev from a
> struct net_device ?  Especially, if the driver does not set
> pci_dev.driver_data to it's net_device struct (such as the acenic
> driver) ?

Forget it. It depends on the driver in both directions. How would it 
handle a pci device with different L2 interfaces or a network adapter
with PCI bridge + various PCI devices behind the bridge ?

-- 
Ueimor
