Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289005AbSBDJyK>; Mon, 4 Feb 2002 04:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289074AbSBDJyA>; Mon, 4 Feb 2002 04:54:00 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:19475 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S289072AbSBDJx5>; Mon, 4 Feb 2002 04:53:57 -0500
Date: Mon, 4 Feb 2002 10:53:54 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Rob Landley <landley@trommello.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <3C5DC138.3080106@zytor.com>
Message-ID: <Pine.LNX.4.44.0202041051220.1381-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Feb 2002, H. Peter Anvin wrote:

> Rob Landley wrote:
> 
> > 
> > You can pivot_root after the bios hands control over to the kernel, sure.  
> > But if the bios can actually boot from arbitrary blocks on the CD before the 
> > kernel takes over, this is news to me.  And for the kernel to read from the 
> > CD, it needs its drivers already loaded for it, so they have to be in that 
> > 2.88 megs somewhere.  (Statically linked, ramdisk, etc.)
> > 
> 
> 
> No, the boot specification allows direct access to the CD.  See the El 
> Torito specification, specifically the parts that talk about "no 
> emulation" mode.

Is this the -hard-disk-boot option of mkisofs?

.TM.

