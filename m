Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285094AbRLFKGf>; Thu, 6 Dec 2001 05:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285097AbRLFKGZ>; Thu, 6 Dec 2001 05:06:25 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1838 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S285092AbRLFKGO>; Thu, 6 Dec 2001 05:06:14 -0500
To: David Woodhouse <dwmw2@infradead.org>
Cc: WRohdewald@dplanet.ch, linux-kernel@vger.kernel.org
Subject: Re: Flash ASUS Bios without Floppy?
In-Reply-To: <20011202230331.E30DA332@localhost.localdomain>
	<4608.1007425933@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Dec 2001 02:45:36 -0700
In-Reply-To: <4608.1007425933@redhat.com>
Message-ID: <m1itbkwukf.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> writes:

> WRohdewald@dplanet.ch said:
> >  how can I update my Bios (Asus A7V266) if I don't have a floppy drive
> > for using the Asus DOS utility?
> 
> > Is there any Linux utililty that can do this? 
> 
> There are flash chip 'map' drivers which know how to enable WE lines, Vpp 
> etc for various northbridges. Only the L440GX one is in the kernel so far. 
> For the rest, ask on the LinuxBIOS list <linuxbios@lanl.gov>.
> 
> Unless you fancy desoldering your flash chips to replace them when, this is
> firmly in the "don't try this at home, kids" category, though :)

Hmm.  Actually most flash chips I have seen for roms have a couple of nice
properties.  1 Voltage so you don't need to play with Vpp.  Either socketed or
their is a jumper that inverts an address line to allow easy switching to a
fallback image.  Of course not all motherboard makers have a clue, but
most do.

It may be worth asking but at this point I don't think anyone has actually
written a driver for the A7V266.  Via hasn't been the most supportive of
companies with the chipset documentation.

Eric
