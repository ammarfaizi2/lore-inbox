Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285327AbRLXVAJ>; Mon, 24 Dec 2001 16:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285328AbRLXVAA>; Mon, 24 Dec 2001 16:00:00 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:15622
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S285327AbRLXU7p>; Mon, 24 Dec 2001 15:59:45 -0500
Date: Mon, 24 Dec 2001 12:58:26 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Stanislav Meduna <stano@meduna.org>, linux-kernel@vger.kernel.org
Subject: Re: IDE CDROM locks the system hard on media error
In-Reply-To: <E16IYGb-0004Uk-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10112241231000.14431-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2001, Alan Cox wrote:

> > I am using vanilla 2.4.17, hdc=ide-scsi, my drive is Mitsumi CR-4804TE,
> > motherboard is Abit BP6 SMP, Intel PIIX4 IDE controller,
> 
> I've seen a few similar reports of this back to about 2.4.10 or so, maybe
> earlier even. Right now I don't think anyone knows what is up

If it is DMAing and there is a 1us transaction delay it is toast.
Intel PIIX4 AB/EB is a NO-NO for doing ATAPI on.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

