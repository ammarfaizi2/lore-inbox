Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSJHTef>; Tue, 8 Oct 2002 15:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263441AbSJHTdc>; Tue, 8 Oct 2002 15:33:32 -0400
Received: from kim.it.uu.se ([130.238.12.178]:54969 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261489AbSJHTcb>;
	Tue, 8 Oct 2002 15:32:31 -0400
Date: Tue, 8 Oct 2002 21:38:11 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210081938.VAA25893@kim.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.41] Oops on reboot in device_remove_file
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-07 20:55:28, Burton Windle wrote:
>2.5.41, after "Rebooting..." is printed, I get this oops:
>
> printing eip:
>c015b1a2
>*pde = 00000000
>Oops: 0002
>CPU:    0
>EIP:    0060:[<c015b1a2>]    Not tainted
>EFLAGS: 00010246
>EIP is at driverfs_remove_file+0x22/0x80

Me too :-( I just got the same oops while rebooting a server which had
done a trial run with 2.5.41. None of my other boxes has had this oops
yet, but the only unique features of the server are that (a) it has two
NICs, and (b) the disks are connected to an add-on PDC20267 card and
I'm using the PDC202XX_OLD driver for it -- PIIX is also enabled but
it only handles the CD-ROM.

/Mikael
