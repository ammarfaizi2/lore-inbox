Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292309AbSBPBoD>; Fri, 15 Feb 2002 20:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292312AbSBPBnx>; Fri, 15 Feb 2002 20:43:53 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:36365
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292309AbSBPBnh>; Fri, 15 Feb 2002 20:43:37 -0500
Date: Fri, 15 Feb 2002 17:32:32 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Andries.Brouwer@cwi.nl
cc: john@mwk.co.nz, linux-kernel@vger.kernel.org, hugo@firstlinux.net
Subject: Re: Need to force IDE geometry
In-Reply-To: <UTC200202152126.VAA28287.aeb@cwi.nl>
Message-ID: <Pine.LNX.4.10.10202151729460.10501-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2002 Andries.Brouwer@cwi.nl wrote:

> > I have a problem with the way the kernel handles geometry.
> 
> Your question is based on your assumptions about geometry
> and LBA. But your assumptions are incorrect, and therefore
> your questions do not make sense. Please tell what you do
> and what error messages you get.
> 
> Andries
> 
> 
> > Else it will be in CHS mode. (ungood)
> 
> False.

It is simple, the raid cards force LBA in the BIOS but Linux choose to
NUKE it and thus the offsets for finding the reserved sectors is all
wrong.  Again we (you) have forced drives to run in CHS by default and it
is wrong.  We can debate but if the drive supports LBA we must force LBA
in the kernel.

Now I am out of this argument.

Cheers,


Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

