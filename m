Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSFNTiP>; Fri, 14 Jun 2002 15:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSFNTiO>; Fri, 14 Jun 2002 15:38:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31748 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313773AbSFNTiO>;
	Fri, 14 Jun 2002 15:38:14 -0400
Message-ID: <3D0A4551.6010607@mandrakesoft.com>
Date: Fri, 14 Jun 2002 15:34:41 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <petero2@telia.com>,
        Patrick Mochel <mochel@osdl.org>, Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.44.0206141057030.2576-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Although there should probably be some way for the driver to tell which
> resources it cares about (some drivers care about the PCI ROM's, for
> example, others don't. Some drivers don't care about the IO region, and
> others don't care about the MEM region). So the _right_ answer might be to
> pass in a bitmap to "pci_enable_device()", which tells the enable code
> which parts the driver really cares about..



Such a mask has been desired before :)

That would indeed be nice.  Still want to keep busmaster enabling 
separate, though...

	Jeff



