Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLKIeq>; Mon, 11 Dec 2000 03:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbQLKIeh>; Mon, 11 Dec 2000 03:34:37 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:56072
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129383AbQLKIeY>; Mon, 11 Dec 2000 03:34:24 -0500
Date: Mon, 11 Dec 2000 00:03:10 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Hakan Lennestal <hakanl@cdt.luth.se>
cc: gsharp@ihug.co.nz, linux-kernel@vger.kernel.org
Subject: Re: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11 
In-Reply-To: <20001210190116.30924418A@tuttifrutti.cdt.luth.se>
Message-ID: <Pine.LNX.4.10.10012110000500.11729-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000, Hakan Lennestal wrote:

> In message <Pine.LNX.4.10.10012100916360.8764-100000@master.linux-ide.org>, And
> re Hedrick writes:
> > On Sun, 10 Dec 2000, Hakan Lennestal wrote:
> > 
> > > The problem being that the kernel hangs after a dma timeout in the
> > > partition detection phase during bootup for speeds higher than udma 44.
> > > This is an IBM-DTLA-307030 connected to a hpt366 pci card on a BH6
> > > motherboard.
> > 
> > Well try the latest out there...test12-pre7.
> 
> Hi !
> 
> This is with test12-pre7 and HPT-bios 1.27.

test12-pre8 and 2.2.18 is out and I do not chase BIOS revs in general.
I work off the originals HPT366 1.07 this is because the lowest comman
variable must be addressed and hope that the new stuff will not fail the
backwards compatablity issue.

Cheers,


Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
