Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132376AbRAVQVu>; Mon, 22 Jan 2001 11:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132057AbRAVQVk>; Mon, 22 Jan 2001 11:21:40 -0500
Received: from staff0130.dada.it ([195.110.97.130]:384 "EHLO
	blacksheep.at.dada.it") by vger.kernel.org with ESMTP
	id <S132376AbRAVQV3>; Mon, 22 Jan 2001 11:21:29 -0500
Date: Mon, 22 Jan 2001 16:32:22 +0100 (CET)
From: Patrizio Bruno <patrizio@dada.it>
To: "J . A . Magallon" <jamagallon@able.es>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: lilo and removable media
In-Reply-To: <20010122161203.A792@werewolf.able.es>
Message-ID: <Pine.LNX.4.10.10101221631170.536-100000@blacksheep.at.dada.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have a look to the lilo.conf man page at the keyword "disk=".

On Mon, 22 Jan 2001, J . A . Magallon wrote:

> Hi, everyone.
> 
> I have recently added an IDE ZIP drive to the system, and when I run lilo
> I get the following messages:
> Jan 22 16:01:05 werewolf kernel: ide-floppy: hda: I/O error, pc =  0, key =  2,
> asc = 3a, ascq =  0
> Jan 22 16:01:05 werewolf kernel: ide-floppy: hda: I/O error, pc = 1b, key =  2,
> asc = 3a, ascq =  0
> Jan 22 16:01:05 werewolf kernel: ide-floppy: hda: I/O error, pc = 5a, key =  5,
> asc = 24, ascq =  0
> 
> Also, if I run lilo with the zip (/dev/hda) mounted, or unmounted but
> still inserted, I get:
> 
> Warning: /dev/sda is not on the first disk
> 
> and the box does not boot, get stuck at 'LI'. If I run lilo without a
> zip in the drive, I get the above messages but al works allright.
> 
> Is there any way to say lilo to ignore hda ?
> 
> My /etc/fstab:
> 
> /dev/sda1	/			ext2	defaults 1 1
> /dev/sda8	swap		swap	defaults 0 0
> proc		/proc		proc	defaults 0 0
> swapfs		/dev/shm	swapfs	defaults 0 0
> devpts		/dev/pts	devpts	mode=0620 0 0
> /dev/sda5	/usr		ext2	defaults 1 2
> /dev/sda6	/usr/local	ext2	defaults 1 2
> /dev/sda7	/home		ext2	defaults 1 2
> /dev/hda	/mnt/zip	auto	user,noauto,nosuid,noexec,nodev 0 0
> /dev/hdc	/mnt/cdrom	auto	user,noauto,nosuid,noexec,nodev,ro
> 0 0
> /dev/fd0	/mnt/floppy	auto	user,noauto,nosuid,noexec,nodev 0
> 0
> 
> -- 
> J.A. Magallon                                                      $> cd pub
> mailto:jamagallon@able.es                                          $> more beer
> 
> Linux werewolf 2.4.0-ac10 #1 SMP Sat Jan 20 10:43:18 CET 2001 i686
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

---------------------------------------------------------
Patrizio Bruno
DADA spa / Ed-IT Development Staff
Borgo degli Albizi 37/r
50122 Firenze
Italy
tel +39 05520351
fax +39 0552478143

PGP PublicKey available at: http://www.keyserver.net/en/
---------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
