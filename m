Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314490AbSDZXN2>; Fri, 26 Apr 2002 19:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314494AbSDZXN1>; Fri, 26 Apr 2002 19:13:27 -0400
Received: from vger.timpanogas.org ([216.250.140.154]:10926 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S314490AbSDZXNX>; Fri, 26 Apr 2002 19:13:23 -0400
Date: Fri, 26 Apr 2002 16:35:20 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>, Wakko Warner <wakko@animx.eu.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 160gb disk showing up as 137gb
Message-ID: <20020426163520.B16100@vger.timpanogas.org>
In-Reply-To: <20020426171836.A3160@animx.eu.org> <Pine.LNX.4.33L2.0204261416040.14014-100000@dragon.pdx.osdl.net> <20020426213411.GQ574@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 02:34:11PM -0700, Mike Fedyk wrote:
> On Fri, Apr 26, 2002 at 02:17:53PM -0700, Randy.Dunlap wrote:
> > On Fri, 26 Apr 2002, Wakko Warner wrote:
> > 
> > | Just bought a maxtor 160gb disk and it shows upt as a 137gb disk.  I thought
> > | this might be the system board's ide chipset limitation so I put a scsi->ide
> > | adapter on the drive.  Same situation occurs.  I'm looking at what the kernel
> > | reports when it finds the drive.  /proc/partitions shows this drive as:
> > |    8     0  134217727 sda
> > | /proc/scsi/scsi shows:
> > | Attached devices:
> > | Host: scsi0 Channel: 00 Id: 00 Lun: 00
> > |   Vendor: Maxtor 4 Model: G160J8           Rev: GAK8
> > |   Type:   Direct-Access                    ANSI SCSI revision: 02
> > |
> > | I tried kernel 2.4.14 and 2.4.18.  Any ideas?
> > 
> > Hi,
> > 
> > There was a thread on this 2-3 months back.
> > IDE in 2.4 doesn't have a 48-bit block address interface IIRC,
> > although Andre has some patches for this.
> > This is necessary to go above 137 GB.
> 
> Wasn't some of that merged into one of the early 2.4.19-pre kernels?
> -


True, but some cards will require a firmware upgrade.

Jeff

> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
