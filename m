Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291169AbSCOLPo>; Fri, 15 Mar 2002 06:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290823AbSCOLOg>; Fri, 15 Mar 2002 06:14:36 -0500
Received: from angband.namesys.com ([212.16.7.85]:22657 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S290277AbSCOLNd>; Fri, 15 Mar 2002 06:13:33 -0500
Date: Fri, 15 Mar 2002 14:13:28 +0300
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-ID: <20020315141328.A1879@namesys.com>
In-Reply-To: <200203110018.BAA11921@webserver.ithnet.com> <15499.64058.442959.241470@charged.uio.no> <20020311091458.A24600@namesys.com> <20020311114654.2901890f.skraw@ithnet.com> <20020311135256.A856@namesys.com> <20020311155937.A1474@namesys.com> <20020315133241.A1636@namesys.com> <20020315120232.6d9b1dd5.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020315120232.6d9b1dd5.skraw@ithnet.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Mar 15, 2002 at 12:02:32PM +0100, Stephan von Krawczynski wrote:
> > Ok I tried your scenario of mounting fs1, then mounting fs2, do io on fs2,
> > umount fs2 and access fs1 and everything went fine.
> > I cannot reproduce this at all. :(
> There must be a reason for this. One "non-standard" option in my setup is in /etc/exports:
> /p2/backup              192.168.1.1(rw,no_root_squash,no_subtree_check)
> Can the "no_subtree_check" be a cause?
I will try with this one.
BTW how much i/o do you usually do to observe an effect.
Are exported filesystems actually reside on one physical flesystem on server
or they are separate physical filesystems too?

> What kernels are you using (client,server)?
2.4.18 at both sides.

Bye,
    Oleg
