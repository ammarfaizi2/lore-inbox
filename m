Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282693AbRLVWD1>; Sat, 22 Dec 2001 17:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282706AbRLVWDO>; Sat, 22 Dec 2001 17:03:14 -0500
Received: from mail.gmx.de ([213.165.64.20]:3990 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S282693AbRLVWDC>;
	Sat, 22 Dec 2001 17:03:02 -0500
Date: Sat, 22 Dec 2001 23:02:24 +0100
From: Christian Ohm <chr.ohm@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: file corruption in 2.4.16/17
Message-ID: <20011222220223.GA537@moongate.thevoid.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Organization: theVoid
X-Operating-System: Linux jumpgate 2.2.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi.

i've recently bought a new 80gb ide drive, and am now getting corrupted
files on it. i've made three partitions for linux on it, a small ext2 one as
root, and two larger ones with reiserfs as /usr and /var. the problem is
that now some files get randomly corrupted; they are the right size, but
contain some random garbage (searching the archive for this list just came
up with some issues around july / kernel 2.4.6), which makes the system
pretty much unusable.

my old setup with a 20gb ide drive and a 4.5gb scsi drive worked flawlessly
for at least a year with reiserfs, so this seems to be a problem with
reiserfs and large drives (i haven't found a corrupted file on the ext2
partition (yet)). my hardware is: a nmc (now enmic) 8tax+ mainboard with via
kt133 chipset (newest bios), a maxtor d540x-4k 80gb harddrive and a quantum
lct15 20gb harddrive. i used kernel 2.4.16 with the preemtion patch, but
2.4.17 seems to have the same problem.

windows had a problem with the maxtor drive, too. i made a fat32 partition
and copied the files from the old drive under linux. worked perfectly, but
when reading the partition with windows, it showed a corrupted file system.
i had to install a special ide driver not included in the via 4in1 drivers
to read it correctly, but now it works without problems.

i'd be happy if there's a solution for this, as, like i said, the system now
is pretty much unusable.

bye
christian ohm

ps.: i'm not subscribed to this list, so please cc me on any replies to this
thread. thanks.
