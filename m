Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263571AbTCUJxH>; Fri, 21 Mar 2003 04:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263572AbTCUJxG>; Fri, 21 Mar 2003 04:53:06 -0500
Received: from angband.namesys.com ([212.16.7.85]:26507 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S263571AbTCUJxG>; Fri, 21 Mar 2003 04:53:06 -0500
Date: Fri, 21 Mar 2003 13:04:02 +0300
From: Oleg Drokin <green@namesys.com>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kswapd oops in 2.4.20 SMP+NFS
Message-ID: <20030321130402.C17440@namesys.com>
References: <1048170204.5161.11.camel@calculon> <20030321112834.A17330@namesys.com> <1048240247.9345.19.camel@fortknox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048240247.9345.19.camel@fortknox>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Mar 21, 2003 at 10:50:47AM +0100, Soeren Sonnenburg wrote:
> > > I got the following oops recently. The machine is still up and running
> > > and was working stably for a year now...
> > > Linux 2.4.20 #1 SMP Tue Dec 10 11:16:20 CET 2002 i686 unknown
> > > 2 x AMD K7-MP 1200MHz PCI(5-64)	TYAN Thunder K7 S2462 Mainboard 1G ECC Memory
> > > [...]
> > > nfsd-fh: found a name that I didn't expect: sys/oz
> > > nfsd-fh: found a name that I didn't expect: sys/oz
> > > nfsd-fh: found a name that I didn't expect: bin/x86
> > > nfsd-fh: found a name that I didn't expect: bin/x86
> > > nfsd-fh: found a name that I didn't expect: etc/bla
> > > VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
> > Hm, what is the underlying host filesystem?
> oops sorry, it is running ext2 on the smaller disks... and reiserfs
> everywhere else but the above files were on a reiserfs partition which
> is rather young (i.e. has not seen anything else than kernel 2.4.20)...

Do you have any idea of what filesystem was unmounted? (the one with busy inodes)

Bye,
    Oleg
