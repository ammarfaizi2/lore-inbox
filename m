Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269049AbRHCNHm>; Fri, 3 Aug 2001 09:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269041AbRHCNHd>; Fri, 3 Aug 2001 09:07:33 -0400
Received: from mail.intrex.net ([209.42.192.246]:59658 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S269049AbRHCNHR>;
	Fri, 3 Aug 2001 09:07:17 -0400
Date: Fri, 3 Aug 2001 09:07:03 -0400
From: jlnance@intrex.net
To: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Ongoing 2.4 VM suckage
Message-ID: <20010803090703.B1248@bessie.localdomain>
In-Reply-To: <Pine.LNX.4.33.0108021508310.21298-100000@heat.gghcwest.com> <Pine.LNX.4.33L.0108021925460.5582-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0108021925460.5582-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Thu, Aug 02, 2001 at 07:27:42PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 07:27:42PM -0300, Rik van Riel wrote:
> On Thu, 2 Aug 2001, Jeffrey W. Baker wrote:
> 
> > I'm telling you that's not what happens.  When memory pressure
> > gets really high, the kernel takes all the CPU time and the box
> > is completely useless. Maybe the VM sorts itself out but after
> > five minutes of barely responding, I usually just power cycle
> > the damn thing.  As I said, this isn't a classic thrash because
> > the swap disks only blip perhaps once every ten seconds!
> 
> What kind of workload are you running ?
> 
> We could be dealing with some weird artifact of
> virtual page scanning here, or with a strange
> side effect of recent VM changes ...

Rik,
    FWIW, I am seeing this sort of thing too, though I am running a 2.4.5
kernel so I am a little out of date.  Its a large machine with 2G of ram,
4G of swap, and 2 CPUs.  You dont have to actually use all the memory either.
When my process gets to about 1.5G and starts doing lots of file I/O, the
machine can just disappear for several minutes.  I will be sshed in and
I can not even get my shell to give me a new prompt when I hit return.  It
will eventually sort it self out, but it might take 15 minutes.  I will try
and get a more recent kernel installed, but the machine is not under my
control, so I dont get to decide when that happens.

Thanks,

Jim
