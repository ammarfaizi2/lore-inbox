Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284451AbRLSJWD>; Wed, 19 Dec 2001 04:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284608AbRLSJVx>; Wed, 19 Dec 2001 04:21:53 -0500
Received: from [212.16.7.124] ([212.16.7.124]:14464 "HELO laputa.namesys.com")
	by vger.kernel.org with SMTP id <S284451AbRLSJVq>;
	Wed, 19 Dec 2001 04:21:46 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15392.23378.580068.10294@laputa.namesys.com>
Date: Wed, 19 Dec 2001 12:18:10 +0300
To: Diego Calleja <grundig@teleline.es>
Cc: linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [grundig@teleline.es: Re: Reiserfs corruption on 2.4.17-rc1!]
In-Reply-To: <20011218221122.B381@diego>
In-Reply-To: <20011217025856.A1649@diego>
	<13425.1008580831@nova.botz.org>
	<20011218003359.A555@diego>
	<15391.12150.650359.33792@laputa.namesys.com>
	<20011218220828.A381@diego>
	<20011218221122.B381@diego>
X-Mailer: VM 6.96 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja writes:
 > 
 > On Tue, 18 Dec 2001 22:08:28 Diego Calleja wrote:
 > 

[...]

 > > 
 > > ftp://ftp.namesys.com/pub/reiserfsprogs/pre/reiserfsprogs-3.x.0k_pre11.tar.gz,
 > > 
 > > build it and run reiserfsck from there. If your root file system is
 > > dead, you will have to do this from some other media (like floppy).
 > Well, I've a copy of all data in another partition...I'm running from it.
 > I've downloaded that version....well, it don't crash, here's output:
 > root@diego:~/reiserfsprogs-3.x.0k_pre11/fsck# ./reiserfsck -i /dev/hdc5
 > 
 > <-------------reiserfsck, 2001------------->
 > reiserfsprogs 3.x.0k_pre11
 > 
 > Will read-only check consistency of the filesystem on /dev/hdc5
 > Will put log info to 'stdout'
 > 
 > Do you want to run this program?[N/Yes] (note need to type Yes):Yes
 > ###########
 > reiserfsck --check started at Tue Dec 18 21:59:12 2001
 > ###########
 > Replaying journal..
 > 0 transactions replayed
 > reserved=8193
 > Checking S+tree../  1 (of   2)/  3 (of 110)/ 15 (of 149)node (10667) with
 > wrong level (18771) found in the tree (should be 1)
 > whole subtree skipped
 > ok
 > Comparing bitmaps..free block count 1970606 mismatches with a correct one
 > 1971004.
 > on-disk bitmap does not match to the correct one. 91 bytes differ
 > Bad nodes were found, Semantic pass skipped
 > There were found 3 corruptions which can be fixed only during
 > --rebuild-tree
 > ###########
 > reiserfsck finished at Tue Dec 18 22:06:23 2001
 > ###########
 > 
 > If I do --rebuild tree, will I lose my data?

You shouldn't. But backup is always your best friend.
And, I am sorry, for misguiding you, last reiserfsprogs are 

ftp://ftp.namesys.com/pub/reiserfsprogs/pre/reiserfsprogs-3.x.0k-pre13.tar.gz

use them in stead.

 > 
 > 
 > > 
 > >  > 	-I'm not a kernel hacker, so I can't try anything...what I
 > > know is
 > >  > that
 > >  > 		/etc in hc5 doesn't work. /usr, /var....works
 > > correctly.
 > >  > 
 > >  > Well, I'd like to know what's happened in my drive. Can somebody try
 > > to
 > >  > give an explanation?
 > >  > 
 > >  > Diego Calleja
 > > 

Nikita.

