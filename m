Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317251AbSFKXzR>; Tue, 11 Jun 2002 19:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317256AbSFKXzQ>; Tue, 11 Jun 2002 19:55:16 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:8663 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317251AbSFKXzP>;
	Tue, 11 Jun 2002 19:55:15 -0400
Date: Tue, 11 Jun 2002 16:55:16 -0700
To: Andi Kleen <ak@suse.de>
Cc: kuznet@ms2.inr.ac.ru, jt@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: Multicast netlink for non-root process
Message-ID: <20020611165516.B23007@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20020611141330.A22927@bougret.hpl.hp.com> <200206112140.BAA14401@sex.inr.ac.ru> <20020612013101.A22399@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 01:31:01AM +0200, Andi Kleen wrote:
> On Wed, Jun 12, 2002 at 01:40:45AM +0400, A.N.Kuznetsov wrote:
> > Hello!
> > 
> > > 	One potential reason is that some of the message may contain
> > > data that is root only. But this should be handled with a finer
> > > granularity.
> > 
> > Exactly. Taking into account that it is not handled with a finer granularity,
> > it is restricted in a facsict manner.
> 
> The only problematic protocols are nf_queue and the firewall netlink I guess.
> 
> This (barely tested) patch should relax it for rtnetlink at least:

	The path works fine here. At least, my non-root app get all
the event proper.
	Thanks a lot for your quick turnaround. I hope it will show up
in 2.5.X someday ;-)

	Jean
