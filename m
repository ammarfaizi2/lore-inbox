Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314676AbSEFTUv>; Mon, 6 May 2002 15:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314685AbSEFTUv>; Mon, 6 May 2002 15:20:51 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:60941 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S314676AbSEFTUu>;
	Mon, 6 May 2002 15:20:50 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Mon, 6 May 2002 13:18:04 -0600
To: Diego Calleja <DiegoCG@teleline.es>
Cc: John Stoffel <stoffel@casc.com>, Dan Kegel <dank@kegel.com>,
        "David S. Miller" <davem@redhat.com>, khttpd-users@alt.org,
        linux-kernel@vger.kernel.org
Subject: Re: Tux in main kernel tree? (was khttpd rotten?)
Message-ID: <20020506131804.G13077@host110.fsmlabs.com>
In-Reply-To: <3CD5ECEE.E6C0B894@kegel.com> <Pine.LNX.4.44.0205061608300.26867-100000@mustard.heime.net> <15574.52864.321544.44124@gargle.gargle.HOWL> <20020506210727.4ed05ba1.DiegoCG@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I put MPI in the kernel and got a huge performance advantage from it.  I
think that was a valuable idea and the results show that's definitely the
case.  I don't think the argument could ever be made that it belongs in the
main kernel, though.  A separate project with a loadable module is
definitely the way to go for these things.

"Keep that out of my kernel" is an old operating system design adage that
isn't paid attention to enough.

} > An httpd server is a *user space* issue, not a kernel issue.
} 
} It's true. But I'd be an idiot if I can improve performance and I don't do it.
} 
} However, if an httpd can be as fast as an kernel space httpd it'd be a bad thing to put it
} in kernel space.
