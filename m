Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281499AbRKUAKK>; Tue, 20 Nov 2001 19:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281505AbRKUAKB>; Tue, 20 Nov 2001 19:10:01 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:24568
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281499AbRKUAJv>; Tue, 20 Nov 2001 19:09:51 -0500
Date: Tue, 20 Nov 2001 16:09:44 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Ricardo Galli <gallir@uib.es>, linux-kernel@vger.kernel.org
Subject: Re: problem with NAT on 2.4
Message-ID: <20011120160944.B4124@mikef-linux.matchmail.com>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Ricardo Galli <gallir@uib.es>, linux-kernel@vger.kernel.org
In-Reply-To: <20011120195443.6842910619@mcrg> <20011120211128.1b9ae5fa.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011120211128.1b9ae5fa.skraw@ithnet.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 09:11:28PM +0100, Stephan von Krawczynski wrote:
> On Tue, 20 Nov 2001 20:54:43 +0100
> Ricardo Galli <gallir@uib.es> wrote:
> 
> > 
> >  > Does anybody have an idea why NAT in 2.4.10 wouldn't work like NAT in some
> >  > cheap dsl-router equipment regarding http-connections?
> >  > Is there any sense in upgrading to 2.4.15-preX?
> >  > I even tried some gateway software based on windoze that is able to NAT - 
> > and
> >  > it works too! I pretty much ran out of ideas...
> > 
> > Did you disable ECN? (echo 0 > /proc/sys/net/ipv4/tcp_ecn)
> 
> Is 0. I didn't explicitely disable, it only happens to be so.
> 
> > Did you try a connection to port 80 from the Linux box?
> 
> Now this is interesting:
> 
> I try a simple telnet www.thedeadman.com 80 (I will post the publicly available
> servers name if you want me to) and this is what happens:
> 
> not working: (connection fails)
> 2.0.39, some 2.2.18, 2.4.10, 2.4.13, some 2.2.19
> 
> working:
> some 2.2.18, some 2.2.19, 2.4.5, 2.4.15-pre3, 2.4.15-pre7

Did you try running tcpdump on the affected server?
