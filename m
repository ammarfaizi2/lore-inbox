Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266567AbRGLUpw>; Thu, 12 Jul 2001 16:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266573AbRGLUpm>; Thu, 12 Jul 2001 16:45:42 -0400
Received: from pop.gmx.net ([194.221.183.20]:19493 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S266567AbRGLUph>;
	Thu, 12 Jul 2001 16:45:37 -0400
Message-ID: <3B4E0CC4.1926053C@gmx.at>
Date: Thu, 12 Jul 2001 22:47:00 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Torrey Hoffman <torrey.hoffman@myrio.com>
CC: "'jesse@cats-chateau.net'" <jesse@cats-chateau.net>,
        Kip Macy <kmacy@netapp.com>, Paul Jakma <paul@clubi.ie>,
        Helge Hafting <helgehaf@idb.hist.no>, "C. Slater" <cslater@wcnet.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting?
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211C92A@mail0.myrio.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torrey Hoffman wrote:
> 
> Jesse Pollard wrote:
> 
> [why switching kernels is very hard, and...]
> 
> > Before you even try switching kernels, first implement a process
> > checkpoint/restart. The process must be resumed after a boot
> > using the same
> > kernel, with all I/O resumed. Now get it accepted into the kernel.
> 
> Hear, hear!  That would be a useful feature, maybe not network servers,
> but for pure number crunching apps it would save people having to write
> all the state saving and recovery that is needed now for long term
> computations.

There is a checkpointing and resumeing lib at
ftp://gutemine.geo.uni-koeln.de/pub/chkpt/
I am not sure if it has been ported to linux yet, but it might be worth
a look.

> 
> For bonus points, make it work for clusters to synchronously save and
> restore state for the apps running on all the nodes at once...
> 
> Torrey

bye,
Wilfried
