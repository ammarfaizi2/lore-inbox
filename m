Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129802AbQLSWRP>; Tue, 19 Dec 2000 17:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbQLSWRF>; Tue, 19 Dec 2000 17:17:05 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:16134 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129802AbQLSWQ4>; Tue, 19 Dec 2000 17:16:56 -0500
Date: Tue, 19 Dec 2000 15:41:29 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: David Hinds <dhinds@valinux.com>
Cc: Miles Lane <miles@megapathdsl.net>, linux-kernel@vger.kernel.org
Subject: Re: PCMCIA modem (v.90 X2) not working with 2.4.0-test12 PCMCIA services
Message-ID: <20001219154129.A1763@vger.timpanogas.org>
In-Reply-To: <007101c067cc$0500c620$0b31a3ce@g1e7m6> <20001218154033.C11728@valinux.com> <20001219114614.A12948@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001219114614.A12948@valinux.com>; from dhinds@valinux.com on Tue, Dec 19, 2000 at 11:46:14AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2000 at 11:46:14AM -0800, David Hinds wrote:
> On Sat, Dec 16, 2000 at 05:52:30PM -0800, Miles Lane wrote:
> > 
> > Socket 1:
> >     product info: "PCMCIA", "V.90 Communications Device ", "", ""
> >     manfid: 0x018a, 0x0001
> 
> Now I have another report of this card not working, under 2.2.
> Perhaps it is a Winmodem?
> 
> -- Dave
> -

David, 

On a related topic, the 3c575_cb driver on an IBM Thinkpad 765D is getting
tx errors on the 2.2.18 kernel with PCMCIA services 3.1.22.

Card is a 3Com 3CCFE575BT Cyclone Cardbus Adapter.

Error is:

eth0:  transmit timed out, tx_status 00 status e000.
  diagnostics net 0cc2 media a800 dma 000000a0

Windows NT 4 and W2K work flawlessly with the same hardware setup, and have
for about 1 year.

Jeff


> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
