Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbRF0XRo>; Wed, 27 Jun 2001 19:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265443AbRF0XRe>; Wed, 27 Jun 2001 19:17:34 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:26374 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S265445AbRF0XRZ>;
	Wed, 27 Jun 2001 19:17:25 -0400
Date: Thu, 28 Jun 2001 09:17:04 +1000
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: tom_gall@vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
Message-ID: <20010628091704.B23627@krispykreme>
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com> <3B3A5B00.9FF387C9@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B3A5B00.9FF387C9@mandrakesoft.com>
User-Agent: Mutt/1.3.18i
From: anton@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Why not use sysdata like the other arches?
> 
> Changing the meaning of dev->bus->number globally seems pointless.  If
> you are going to do that, just do it the right way and introduce another
> struct member, pci_domain or somesuch.

Thats 2.5 material. For 2.4 we should do as davem suggested and make
the bus number unique. I do this by just adding 256 to each overlapping
host bridge.

Anton
