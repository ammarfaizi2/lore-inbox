Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268900AbRHWQlg>; Thu, 23 Aug 2001 12:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269067AbRHWQlR>; Thu, 23 Aug 2001 12:41:17 -0400
Received: from web9307.mail.yahoo.com ([216.136.129.56]:34057 "HELO
	web9307.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268926AbRHWQlF>; Thu, 23 Aug 2001 12:41:05 -0400
Message-ID: <20010823164120.37497.qmail@web9307.mail.yahoo.com>
Date: Thu, 23 Aug 2001 09:41:20 -0700 (PDT)
From: John paul R <jpr200012@yahoo.com>
Subject: Re: dell inspiron 8000 eepro100 problems
To: linux-kernel@vger.kernel.org
In-Reply-To: <3B84B818.6F7E7139@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Arjan van de Ven <arjanv@redhat.com> wrote:
> Matt_Domsch@Dell.com wrote:
> > 
> > > i'm using 2.4.9 and have had a problem since 2.2
> > > kernels along with all versions of 2.4. i am
> having a
> > > problem with 2 laptops, both are dell inspiron
> 8000
> > > that have intel 82557 mini-pci nic in them. i
> get no
> > 
> > <Not official support>
> > 
> > Is the "sleep mode bit" set on the NIC?  Please
> try Donald Becker's
> > eepro100-diag.c program, located at
> > ftp://ftp.scyld.com/pub/diag/eepro100-diag.c, and
> use the -G -w -w -w flags
> > to clear that bit if running it first says that
> the sleep bit is enabled.
> > This may help.

i tried this last night - still same problem (sleep
was enabled originally)

> 
> It won't for the suspend case; the bios just forgets
> to re-enable the 
> PCI bridge to and the eepro100 card itself during
> resume. I have a patch 
> to work around this and will clean it up enough for
> it to be acceptable 
> for the mainstream kernel.

just to note i don't suspend when this happens (or
ever really).

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
