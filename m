Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284491AbRLXJUH>; Mon, 24 Dec 2001 04:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284506AbRLXJT6>; Mon, 24 Dec 2001 04:19:58 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:11786 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S284491AbRLXJTl>; Mon, 24 Dec 2001 04:19:41 -0500
Message-ID: <3C26F2AC.1050809@namesys.com>
Date: Mon, 24 Dec 2001 12:17:32 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christian Ohm <chr.ohm@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: file corruption in 2.4.16/17
In-Reply-To: <20011222220223.GA537@moongate.thevoid.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Ohm wrote:

>hi.
>
>i've recently bought a new 80gb ide drive, and am now getting corrupted
>files on it. i've made three partitions for linux on it, a small ext2 one as
>root, and two larger ones with reiserfs as /usr and /var. the problem is
>that now some files get randomly corrupted; they are the right size, but
>contain some random garbage (searching the archive for this list just came
>up with some issues around july / kernel 2.4.6), which makes the system
>pretty much unusable.
>
>my old setup with a 20gb ide drive and a 4.5gb scsi drive worked flawlessly
>for at least a year with reiserfs, so this seems to be a problem with
>reiserfs and large drives (i haven't found a corrupted file on the ext2
>partition (yet)). my hardware is: a nmc (now enmic) 8tax+ mainboard with via
>kt133 chipset (newest bios), a maxtor d540x-4k 80gb harddrive and a quantum
>lct15 20gb harddrive. i used kernel 2.4.16 with the preemtion patch, but
>2.4.17 seems to have the same problem.
>
>windows had a problem with the maxtor drive, too. i made a fat32 partition
>and copied the files from the old drive under linux. worked perfectly, but
>when reading the partition with windows, it showed a corrupted file system.
>i had to install a special ide driver not included in the via 4in1 drivers
>to read it correctly, but now it works without problems.
>
>i'd be happy if there's a solution for this, as, like i said, the system now
>is pretty much unusable.
>
>bye
>christian ohm
>
>ps.: i'm not subscribed to this list, so please cc me on any replies to this
>thread. thanks.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
ReiserFS does not have a problem with large hard drives.  If you crash 
while writing a file, you can damage it.  Not sure if that is your 
problem, but maybe.


Hans


