Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267210AbSLRKEG>; Wed, 18 Dec 2002 05:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbSLRKEG>; Wed, 18 Dec 2002 05:04:06 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:41479 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S267210AbSLRKEF>; Wed, 18 Dec 2002 05:04:05 -0500
Date: Wed, 18 Dec 2002 13:11:24 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Dave Jones <davej@codemonkey.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: kill pdev_enable_device()
Message-ID: <20021218131124.A18949@jurassic.park.msu.ru>
References: <20021217201938.A16940@jurassic.park.msu.ru> <3DFFA5DD.4030804@pobox.com> <20021218004226.GA3204@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021218004226.GA3204@suse.de>; from davej@codemonkey.org.uk on Wed, Dec 18, 2002 at 12:42:26AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 12:42:26AM +0000, Dave Jones wrote:
> On Tue, Dec 17, 2002 at 05:31:57PM -0500, Jeff Garzik wrote:
>  > Not only that, a driver _should_ be calling pci-enable-device, it's an 
>  > API requirement.  J Random Driver should have a good reason _not_ to 
>  > call pci_enable_device() ...
> 
> What about the xircom issue that was discussed in the last days ?
> Sounds like the solution isn't a full on pci_enable_device() as
> pcmcia 'knows better than us' at that stage aparently.

pdev_enable_device() has nothing to do with pcmcia anyway. :-)

Ivan.
