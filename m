Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262668AbREOHtd>; Tue, 15 May 2001 03:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262666AbREOHtX>; Tue, 15 May 2001 03:49:23 -0400
Received: from 20dyn175.com21.casema.net ([213.17.90.175]:36868 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S262663AbREOHtP>;
	Tue, 15 May 2001 03:49:15 -0400
Date: Tue, 15 May 2001 09:48:36 +0200
From: bert hubert <ahu@ds9a.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@transmeta.org
Subject: 2.4 To Pending Device Number Registrants
Message-ID: <20010515094835.A13650@home.ds9a.nl>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	torvalds@transmeta.org
In-Reply-To: <Pine.GSO.4.21.0105141856090.19333-100000@weyl.math.psu.edu> <E14zRIW-0001dr-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <E14zRIW-0001dr-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, May 14, 2001 at 11:58:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 11:58:39PM +0100, Alan Cox wrote:
> Yet another 2.5 project. If Linus wants to go play with name driven devices
> and you want to help him great, but if he'd care to put out
> linux-2.5.0.tar.gz _before_ starting that would be good for all of us

Well, that's one thing. 2.4 will not need userspace changes internally, so
any funky major/minor number dynamic allocation stuff needs to be solved
without userspace help. This probably rules out most everything, unless a
setup is found that will special case all of /dev/ currently existing.

So I would think that this block of new major number allocations holds for
2.5 and not 2.4. Also, if I'm correct, 2.4 won't be needing a lot of new
major numbers anyhow.

This all means that a lot of the current hubbub is unjustified - 2.5 is not
there yet. Yes there is urgency and this way of forcing discussion is a very
Linus-eque way of trying to achieve something.

But unless I'm wrong, there is no way that this can affect a 2.4 without
userspace changes which have historically been considered forbidden within a
stable series.

Regards,

bert

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
