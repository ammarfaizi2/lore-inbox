Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289201AbSAVRu6>; Tue, 22 Jan 2002 12:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289181AbSAVRut>; Tue, 22 Jan 2002 12:50:49 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:19972
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S289201AbSAVRue>; Tue, 22 Jan 2002 12:50:34 -0500
Date: Tue, 22 Jan 2002 18:50:31 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Nils Rennebarth <nils@ipe.uni-stuttgart.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17: Hang after IDE detection
Message-ID: <20020122185031.A21427@bouton.inet6-interne.fr>
Mail-Followup-To: Nils Rennebarth <nils@ipe.uni-stuttgart.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201221421050.20914-100000@aither.zcu.cz> <Pine.GSO.4.21.0201221547420.18952-100000@skiathos.physics.auth.gr> <20020122173815.GH900@ipe.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020122173815.GH900@ipe.uni-stuttgart.de>; from nils@ipe.uni-stuttgart.de on Tue, Jan 22, 2002 at 06:38:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 06:38:15PM +0100, Nils Rennebarth wrote:
> On Tue, Jan 22, 2002 at 05:18:27PM +0200, Liakakis Kostas wrote:
> > I recently got an older k6-2/333 with a SiS chipset and tried to install
> > linux on it.
> > 
> > Every recent distro I tryed with a 2.4.x kernel would hang after detecting
> > the SiS5513 controller.
> 
> > SIS5513: chipset revision 208
> > SIS5513: not 100% native mode: will probe irqs later
> > SIS5597
> >     ide0: BM-DMA at 0x4000-0x4007, BIOS settings hda:pio, hdb:pio
> >     ide1: BM-DMA at 0x4008-0x400f, BIOS settings hdc:pio, hdb:pio
> for me the hang happens here. Other symptoms are about the same.
> 
> > hda: ST34321A, ATA DISK drive
> > hdc: CD-540E, ATAPI CD/DVD-DROM drive
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on ira 15
> > <hang>
> all recent (>=16) and a 2.4.6 pre7 kernel hang. 2.2.19 is no problem.
> 
> Nils

Support for the 5597 coming in. Without net connection at home though.
May have to use floppy disks to bring code with me at work and then post.
Expect a post with an alpha version of ATA16/ATA33 chips support and
some ATA66 bugfixes before the week's end.

LB.
