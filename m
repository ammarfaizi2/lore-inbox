Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281236AbRKHBNY>; Wed, 7 Nov 2001 20:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281232AbRKHBNO>; Wed, 7 Nov 2001 20:13:14 -0500
Received: from smtp3.libero.it ([193.70.192.53]:17819 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S281228AbRKHBNF>;
	Wed, 7 Nov 2001 20:13:05 -0500
Date: Thu, 8 Nov 2001 02:04:22 +0100
From: antirez <antirez@invece.org>
To: Stephen Satchell <satch@concentric.net>
Cc: antirez <antirez@invece.org>,
        "Brenneke, Matthew Jeffrey (UMR-Student)" <mbrennek@umr.edu>,
        "'H. Peter Anvin'" <hpa@zytor.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Yet another design for /proc. Or actually /kernel.
Message-ID: <20011108020422.D568@blu>
Reply-To: antirez <antirez@invece.org>
In-Reply-To: <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu> <6CAC36C3427CEB45A4A6DF0FBDABA56D59C91D@umr-mail03.cc.umr.edu> <20011108012051.C568@blu> <4.3.2.7.2.20011107164408.00c043f0@10.1.1.42>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4.3.2.7.2.20011107164408.00c043f0@10.1.1.42>; from satch@concentric.net on Wed, Nov 07, 2001 at 04:44:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 04:44:50PM -0800, Stephen Satchell wrote:
> At 01:20 AM 11/8/01 +0100, antirez wrote:
> >/proc/mounts will be:
> >
> >((rem)(mounted filesystems))
> >((format)(device)(mountpoint)(type)(option)(dump)(fsck))
> >((data)(dev/hda1)(/home/mbrennek/stuff and)(vfat)(rw)(0)(0))
> >((data)(/dev/hda2)(/var/tmp)(ext2)(rw)(0)(0))
> >((rem)(number of filesystems mounted))
> >((format)(mount_count))
> >((data)(2))
> 
> Looks a little like LISPTH.  Flex and Bison to the rescue!
> 
> (signed) anonymous

I'm really a newbie. Maybe I missed the whole point but
stay sure you don't need flex and bison to parse this.
It's _really_ simple, you need little code of little
complexity, to get something of flexible that can be
used for long time.

If you don't trust me I can write a little C library to parse
this just for provide a proof.
This isn't only simple to parse, but even simple to generate,
that's an important point.

regards,
Salvatore
