Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272493AbRIFSg6>; Thu, 6 Sep 2001 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272489AbRIFSgu>; Thu, 6 Sep 2001 14:36:50 -0400
Received: from ns.suse.de ([213.95.15.193]:6675 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S272483AbRIFSgf>;
	Thu, 6 Sep 2001 14:36:35 -0400
Date: Thu, 6 Sep 2001 20:36:46 +0200
From: Andi Kleen <ak@suse.de>
To: Wietse Venema <wietse@porcupine.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Friesen <cfriesen@nortelnetworks.com>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernel.org
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010906203646.A11741@gruyere.muc.suse.de>
In-Reply-To: <E15ehVC-0006Rx-00@the-village.bc.nu> <20010905212326.1B82DBC06C@spike.porcupine.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010905212326.1B82DBC06C@spike.porcupine.org>; from wietse@porcupine.org on Wed, Sep 05, 2001 at 05:23:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sending a similar mail for the third time now; you conveniently chosed 
to ignore all earlier ones of me in the discussion. I will not send another
one, but just quietly think "Wietse is a moron" before forgetting the issue]

On Wed, Sep 05, 2001 at 05:23:26PM -0400, Wietse Venema wrote:
> On a more serious note, what portable primitives does Linux offer
> to look up all interface IP addresses and their corresponding
> netmasks?

man rtnetlink 7

> The primitives used in Postfix work on all supported systems, except
> for Linux where they work partially.
> 
> Portability is a relative thing - it would be wonderful already if
> your primitive supports the past three years of kernel releases.

It does (Since 2.1.x;x>=2x or so)

-Andi
