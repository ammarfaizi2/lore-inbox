Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262298AbSKCSZA>; Sun, 3 Nov 2002 13:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbSKCSZA>; Sun, 3 Nov 2002 13:25:00 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:10650 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S262298AbSKCSY7>;
	Sun, 3 Nov 2002 13:24:59 -0500
Date: Sun, 3 Nov 2002 11:25:10 -0700
From: yodaiken@fsmlabs.com
To: Linus Torvalds <torvalds@transmeta.com>
Cc: yodaiken@fsmlabs.com, Alexander Viro <viro@math.psu.edu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021103112510.A1873@hq.fsmlabs.com>
References: <20021103095612.A436@hq.fsmlabs.com> <Pine.LNX.4.44.0211031003170.11657-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211031003170.11657-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Nov 03, 2002 at 10:13:37AM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 10:13:37AM -0800, Linus Torvalds wrote:
> 
> On Sun, 3 Nov 2002 yodaiken@fsmlabs.com wrote:
> > 
> > Plan 9 !
> 
> Well, yes. But also Linux. The code is all there, and you can create a new
> namespace group with just a simple CLONE_NEWNS. Then you just do
> pivot_root() in that namespace, unmount the old root, and you're done.

So capabilities then just seems like a hack.  You can write a trusted
user space suid gateway program that consults a database, builds you a
temporary file system with links and permissions to an otherwise hidden
shared tree and puts you safely in that "temporary  tree". If I understand
what this does.



As for Al, he may be a great programmer, but it's his polemical 
writing style I appreciate most.

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
www.fsmlabs.com  www.rtlinux.com
1+ 505 838 9109

