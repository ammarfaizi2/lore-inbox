Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285130AbRLWGtY>; Sun, 23 Dec 2001 01:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284017AbRLWGtO>; Sun, 23 Dec 2001 01:49:14 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:38405
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S283860AbRLWGtK>; Sun, 23 Dec 2001 01:49:10 -0500
Date: Sat, 22 Dec 2001 22:48:35 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Christian Ohm <chr.ohm@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: file corruption in 2.4.16/17
In-Reply-To: <20011222220223.GA537@moongate.thevoid.net>
Message-ID: <Pine.LNX.4.10.10112222218220.8976-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christian,

Don't take the tone personally, it is directed at the primary kernel
maintainers.

Well I will promise you that it is not my driver!  Additionally there has
been a private blanket test to authenticate it is doing the correct thing.
Now the legacy driver in the stock kernels have the ablitity to fail but
very rarely.

So I suggest you use a corrected driver found at www.linuxdiskcert.org.

There will be an update for 2.4.17, but if you choose the use the legacy
driver and you have FSC, TOUGH!  I have offered out a tested and domain
validated driver and nobody wants it.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project


On Sat, 22 Dec 2001, Christian Ohm wrote:

> 
> hi.
> 
> i've recently bought a new 80gb ide drive, and am now getting corrupted
> files on it. i've made three partitions for linux on it, a small ext2 one as
> root, and two larger ones with reiserfs as /usr and /var. the problem is
> that now some files get randomly corrupted; they are the right size, but
> contain some random garbage (searching the archive for this list just came
> up with some issues around july / kernel 2.4.6), which makes the system
> pretty much unusable.
> 
> my old setup with a 20gb ide drive and a 4.5gb scsi drive worked flawlessly
> for at least a year with reiserfs, so this seems to be a problem with
> reiserfs and large drives (i haven't found a corrupted file on the ext2
> partition (yet)). my hardware is: a nmc (now enmic) 8tax+ mainboard with via
> kt133 chipset (newest bios), a maxtor d540x-4k 80gb harddrive and a quantum
> lct15 20gb harddrive. i used kernel 2.4.16 with the preemtion patch, but
> 2.4.17 seems to have the same problem.
> 
> windows had a problem with the maxtor drive, too. i made a fat32 partition
> and copied the files from the old drive under linux. worked perfectly, but
> when reading the partition with windows, it showed a corrupted file system.
> i had to install a special ide driver not included in the via 4in1 drivers
> to read it correctly, but now it works without problems.
> 
> i'd be happy if there's a solution for this, as, like i said, the system now
> is pretty much unusable.
> 
> bye
> christian ohm
> 
> ps.: i'm not subscribed to this list, so please cc me on any replies to this
> thread. thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

