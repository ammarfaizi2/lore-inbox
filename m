Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272507AbRIFTFZ>; Thu, 6 Sep 2001 15:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272505AbRIFTFQ>; Thu, 6 Sep 2001 15:05:16 -0400
Received: from ns.suse.de ([213.95.15.193]:18182 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S272501AbRIFTFE>;
	Thu, 6 Sep 2001 15:05:04 -0400
Date: Thu, 6 Sep 2001 21:05:23 +0200
From: Andi Kleen <ak@suse.de>
To: Wietse Venema <wietse@porcupine.org>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Friesen <cfriesen@nortelnetworks.com>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernel.org
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010906210523.A12207@gruyere.muc.suse.de>
In-Reply-To: <20010906203646.A11741@gruyere.muc.suse.de> <20010906185124.42C37BC06C@spike.porcupine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010906185124.42C37BC06C@spike.porcupine.org>; from wietse@porcupine.org on Thu, Sep 06, 2001 at 02:51:24PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 02:51:24PM -0400, Wietse Venema wrote:
> > On Wed, Sep 05, 2001 at 05:23:26PM -0400, Wietse Venema wrote:
> > > On a more serious note, what portable primitives does Linux offer
> > > to look up all interface IP addresses and their corresponding
> > > netmasks?
> > 
> > man rtnetlink 7
> 
> It's not portable as you may believe.

The man pages are actually came years later than the code due to some accidents.
That doesn't change the existence of the code.

> 
>     [root@redhat52 /root]# man rtnetlink
>     No manual entry for rtnetlink
> 
> This was released only three years ago.
> 
> But it does not matter. The code needs to be written anyway.
> 
> Do you have more to share than RFTM? Pointers to code?

Most prominent example is iproute2. It should be included as source with any 
recent linux distribution. Others are zebra or bird.

-Andi
