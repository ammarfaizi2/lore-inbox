Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265724AbUFUB4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbUFUB4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 21:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265992AbUFUB4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 21:56:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30378 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265724AbUFUB4V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 21:56:21 -0400
Date: Sun, 20 Jun 2004 22:49:10 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       Ryan Underwood <nemesis-lists@icequake.net>,
       Willy Tarreau <willy@w.ods.org>, twaugh@redhat.com, akpm@osdl.org
Subject: Netmos 9835 in 2.6.x was Request: Netmos support in parport_serial for 2.4.27 
Message-ID: <20040621014910.GC9359@logos.cnet>
References: <20040613111949.GB6564@dbz.icequake.net> <20040613123950.GA3332@logos.cnet> <Pine.LNX.4.56.0406132225020.5930@jjulnx.backbone.dif.dk> <20040613220727.GB4771@logos.cnet> <20040614045104.GE27622@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614045104.GE27622@dbz.icequake.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 11:51:04PM -0500, Ryan Underwood wrote:
> On Sun, Jun 13, 2004 at 07:07:27PM -0300, Marcelo Tosatti wrote:
> > 
> > Jesper, 
> > 
> > Two more things.
> > 
> > It seems v2.6 also lacks support for this boards:
> > 
> > grep PCI_DEVICE_ID_NETMOS_ *
> > pci_ids.h:#define PCI_DEVICE_ID_NETMOS_9735     0x9735
> > pci_ids.h:#define PCI_DEVICE_ID_NETMOS_9835     0x9835
> > [marcelo@localhost linux]$
> > 
> > Care to prepare a v2.6 version?
> 
> Seems like someone already did, but I guess it did not get applied for
> some reasons:
> http://seclists.org/lists/linux-kernel/2003/Dec/0654.html

Andrew, the patch in the URL looks fine to me, it adds support for 
Netmos 9835 based cards. Tim Waugh ACKed the 2.4 version of the patch. 

Christopher Lameter updated the patch for v2.6, and it looks 
alright to me. Please check the URL.

Quoting him:

"Attached a patch to support a variety of PCI based serial and parallel
port I/O ports (typically labeled 222N-2 or 9835). The patch was

I just fixed it up and made it work for 2.6.0-test10/10.

I think this should go into 2.6.0 since it has been out there for a long
time and is just some additional driver support that somehow fell through
the cracks in 2.4.X. Tim Waugh submitted it in the 2.4.X series."

I'm sure the fellows in this thread who posses the cards 
can give it a test.

