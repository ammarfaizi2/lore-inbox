Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135971AbREGBma>; Sun, 6 May 2001 21:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135973AbREGBmV>; Sun, 6 May 2001 21:42:21 -0400
Received: from unthought.net ([212.97.129.24]:53381 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S135971AbREGBmK>;
	Sun, 6 May 2001 21:42:10 -0400
Date: Mon, 7 May 2001 03:42:08 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Ben Ford <ben@kalifornia.com>
Cc: "Dwayne C. Litzenberger" <dlitz@dlitz.net>,
        Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPU hot swap for 2.4.3 + s390 support
Message-ID: <20010507034208.A16593@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Ben Ford <ben@kalifornia.com>,
	"Dwayne C. Litzenberger" <dlitz@dlitz.net>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010505063726.A32232@va.samba.org> <20010506011553.A11297@zed.dlitz.net> <3AF584A2.4050208@kalifornia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3AF584A2.4050208@kalifornia.com>; from ben@kalifornia.com on Sun, May 06, 2001 at 10:06:42AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2001 at 10:06:42AM -0700, Ben Ford wrote:
> Dwayne C. Litzenberger wrote:
> 
> >Hey, this is cool.
> >
> >How far away is the capability to "teleport" processes from one machine to
> >another over the network?  Think of the uptime!
> >
> 
> It is here.  Look at Mosix.

No.  Not for uptime.

The "responsibility" for process completion does not get delegated. A process
will always be bound to it's home-node (in mosix terms), no matter how far
it's "teleported".   If the home-node fails, the process won't know what hit
it.

There are good reasons why mosix let's processes depend on their home nodes.

This is not meant as backstabbing mosix, it's a great environment for a lot
of things.

But it's not the universal silver bullet.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
