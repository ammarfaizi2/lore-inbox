Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSIAHUG>; Sun, 1 Sep 2002 03:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSIAHUG>; Sun, 1 Sep 2002 03:20:06 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:57040 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316499AbSIAHUF>; Sun, 1 Sep 2002 03:20:05 -0400
Date: Sun, 1 Sep 2002 03:24:26 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: [PATCH] POSIX message queues
Message-ID: <20020901032426.X7920@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20020827231625.A7961@infradead.org> <Pine.GSO.4.40.0208311516100.7165-100000@ultra60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.40.0208311516100.7165-100000@ultra60>; from golbi@mat.uni.torun.pl on Sat, Aug 31, 2002 at 03:28:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2002 at 03:28:43PM +0200, Krzysztof Benedyczak wrote:
> Hello,
> 
> On Tue, 27 Aug 2002, Christoph Hellwig wrote:
> > The multiplexer syscall is horribly ugly. I'd suggest implementing it
> > as filesystems so each message queue object can be represented as file,
> > using defined file methods as much as possible.
> 
> It seems clever. In fact previous version used file representation in
> very simple and rather undesirable way so we resigned from it. But we
> can try to change it.

I have written MQ as filesystem about 2 years ago, see:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0011.2/0639.html
(though did not manage to update it since then).
Dunno if it is easier to update the patch or write it from scratch though...

	Jakub
