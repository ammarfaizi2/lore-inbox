Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265473AbRF1BA4>; Wed, 27 Jun 2001 21:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265464AbRF1BAp>; Wed, 27 Jun 2001 21:00:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28564 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265468AbRF1BAa>;
	Wed, 27 Jun 2001 21:00:30 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15162.33196.203709.242026@pizda.ninka.net>
Date: Wed, 27 Jun 2001 18:00:28 -0700 (PDT)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: tom_gall@vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <3B3A5B00.9FF387C9@mandrakesoft.com>
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com>
	<3B3A5B00.9FF387C9@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeff Garzik writes:
 > >   Is this reasonable for everyone?
 > 
 > Why not use sysdata like the other arches?

Right.

 > Changing the meaning of dev->bus->number globally seems pointless.  If
 > you are going to do that, just do it the right way and introduce another
 > struct member, pci_domain or somesuch.

Actually, the concept of "system domains" is what we had finally
talked about.

Later,
David S. Miller
davem@redhat.com
