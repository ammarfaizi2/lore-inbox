Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290228AbSA3RNs>; Wed, 30 Jan 2002 12:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290119AbSA3RM7>; Wed, 30 Jan 2002 12:12:59 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:16902 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290115AbSA3RMo>;
	Wed, 30 Jan 2002 12:12:44 -0500
Date: Wed, 30 Jan 2002 09:11:26 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>, mingo@elte.hu,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130171126.GA26583@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0201300110420.1542-100000@penguin.transmeta.com> <E16VrdT-0006t7-00@the-village.bc.nu> <20020130051855.E11267@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020130051855.E11267@havoc.gtf.org>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 02 Jan 2002 14:38:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 05:18:55AM -0500, Jeff Garzik wrote:
> On Wed, Jan 30, 2002 at 10:06:35AM +0000, Alan Cox wrote:
> > The other related question is device driver implementation stuff (not interfaces
> > and abstractions). You don't seem to check that much anyway, or have any taste
> > in device drivers 8) so should that be part of the small fixing job ?
> 
> I've often dreamt of an overall "drivers maintainer" or perhaps just an
> unmaintained-drivers maintainer:  a person with taste who could give
> driver patches a glance, when noone else does.
> (and no I'm not volunteering :))

I have had that same dream too, Jeff :)
Especially after spelunking through the SCSI drivers, and being amazed
that only one of them uses the, now two year old, pci_register_driver()
interface (which means that only that driver works properly in PCI
hotplug systems.)

Having someone with "taste" to run driver patches by first would have
been a great help when I started out writing them.  I've been trying to
provide that resource for the new USB drivers.

greg k-h
