Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280755AbRKJXPW>; Sat, 10 Nov 2001 18:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280756AbRKJXPN>; Sat, 10 Nov 2001 18:15:13 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:64244
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280755AbRKJXOy>; Sat, 10 Nov 2001 18:14:54 -0500
Date: Sat, 10 Nov 2001 15:14:41 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: J Sloan <jjs@pobox.com>
Cc: Sven Vermeulen <sven.vermeulen@rug.ac.be>,
        Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: Re: Networking: repeatable oops in 2.4.15-pre2
Message-ID: <20011110151441.D446@mikef-linux.matchmail.com>
Mail-Followup-To: J Sloan <jjs@pobox.com>,
	Sven Vermeulen <sven.vermeulen@rug.ac.be>,
	Linux-Kernel Development Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20011110132139.A872@Zenith.starcenter> <3BED766B.BEBA6EB0@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BED766B.BEBA6EB0@pobox.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2001 at 10:48:11AM -0800, J Sloan wrote:
> Sven Vermeulen wrote:
> 
> > J Sloan (jjs@pobox.com) wrote:
> > > I have been running the 2.4.15-pre kernels and
> > > have found an interesting oops. I can reproduce
> > > it immediately, and reliably, just by issuing an ssh
> > > command (as a normal user).
> >
> > I'm currently running Linux 2.4.15-pre2 and have no troubles with ssh. I can
> > safely login onto other hosts, or issuing commands like
> >         ssh -l someuser@somehost mutt
> > or copy files
> >         scp somefile someuser@somehost:
> >
> > I'm not using OpenSSH 3.0 yet (2.9p2). I'm not running any firewall or
> > transparent proxying.
> 
> Thanks for the info, this is what I suspected -
> 
> only people running iptables appear to be
> seeing this problem.
> 

I don't know...

I have netfilter compiled in, but I don't have any filter rules yet.  This
is on smp too...

Have you been able to tell if you need to use mangling, or nat, or will just
filter rules do the job of reproducing?

Mike
