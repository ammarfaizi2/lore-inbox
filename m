Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263570AbTCUJtD>; Fri, 21 Mar 2003 04:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263571AbTCUJtD>; Fri, 21 Mar 2003 04:49:03 -0500
Received: from mail.mediaways.net ([193.189.224.113]:50724 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S263570AbTCUJtC>; Fri, 21 Mar 2003 04:49:02 -0500
Subject: Re: kswapd oops in 2.4.20 SMP+NFS
From: Soeren Sonnenburg <kernel@nn7.de>
To: Oleg Drokin <green@namesys.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030321112834.A17330@namesys.com>
References: <1048170204.5161.11.camel@calculon>
	 <20030321112834.A17330@namesys.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048240247.9345.19.camel@fortknox>
Mime-Version: 1.0
Date: 21 Mar 2003 10:50:47 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-21 at 09:28, Oleg Drokin wrote:
> Hello!
> 
> On Thu, Mar 20, 2003 at 03:23:24PM +0100, Soeren Sonnenburg wrote:
> 
> > I got the following oops recently. The machine is still up and running
> > and was working stably for a year now...
> > Linux 2.4.20 #1 SMP Tue Dec 10 11:16:20 CET 2002 i686 unknown
> > 2 x AMD K7-MP 1200MHz PCI(5-64)	TYAN Thunder K7 S2462 Mainboard 1G ECC Memory
> > [...]
> > nfsd-fh: found a name that I didn't expect: sys/oz
> > nfsd-fh: found a name that I didn't expect: sys/oz
> > nfsd-fh: found a name that I didn't expect: bin/x86
> > nfsd-fh: found a name that I didn't expect: bin/x86
> > nfsd-fh: found a name that I didn't expect: etc/bla
> > VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
> 
> Hm, what is the underlying host filesystem?

oops sorry, it is running ext2 on the smaller disks... and reiserfs
everywhere else but the above files were on a reiserfs partition which
is rather young (i.e. has not seen anything else than kernel 2.4.20)...

Soeren

