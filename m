Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbSJ2K6b>; Tue, 29 Oct 2002 05:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261502AbSJ2K6b>; Tue, 29 Oct 2002 05:58:31 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:19415 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261347AbSJ2K6a>;
	Tue, 29 Oct 2002 05:58:30 -0500
Date: Tue, 29 Oct 2002 12:04:51 +0100
From: bert hubert <ahu@ds9a.nl>
To: Andrew Morton <akpm@digeo.com>
Cc: Hanna Linder <hannal@us.ibm.com>, torvalds@transmeta.com,
       Davide Libenzi <davidel@xmailserver.org>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Updated sys_epoll now with man pages
Message-ID: <20021029110451.GA11670@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrew Morton <akpm@digeo.com>, Hanna Linder <hannal@us.ibm.com>,
	torvalds@transmeta.com, Davide Libenzi <davidel@xmailserver.org>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	lse-tech@lists.sourceforge.net
References: <Pine.LNX.4.44.0210281844040.966-100000@blue1.dev.mcafeelabs.com> <144220000.1035864069@w-hlinder> <3DBE1824.B3D84E9F@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBE1824.B3D84E9F@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 09:09:56PM -0800, Andrew Morton wrote:

> when I took a 15-minute look at this code last week I found several
> bugs, some of which were grave.  It's a terrible thing to say, but

Are there still unresolved bugs? 

> epoll seems to be a good and desirable thing.  To move forward I
> believe we need to get this code reviewed, and documented.

Davide's code explanation looks nice - do you think it sufficient?

> I can do that if you like; it will take me several weeks to get onto
> it.  But until that is completed I would oppose inclusion of this
> code.

This sounds real harsh as this means that it does not, in fact, go in. I'm
no guru but the code in question looks sane and reasonable. The state of the
kernel right now is such that I would really advocate this going in, I'm
sure we can get commitment to vet this code - which is all the easier
because it is going to see more use.

I'll be releasing a version of mtasker (http://ds9a.nl/mtasker) later today
which uses epoll which I'm going to take into production.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
