Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268729AbRG0Luf>; Fri, 27 Jul 2001 07:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268832AbRG0LuZ>; Fri, 27 Jul 2001 07:50:25 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:6530 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S268729AbRG0LuK>; Fri, 27 Jul 2001 07:50:10 -0400
Message-ID: <3B6154E2.B590E8E8@randomlogic.com>
Date: Fri, 27 Jul 2001 04:47:46 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linx Kernel Source tree and metrics
In-Reply-To: <20010727095757Z268814-721+5010@vger.kernel.org> <15201.17117.641766.521810@notabene.cse.unsw.edu.au> <20010727131858.H11840@lug-owl.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Jan-Benedict Glaw wrote:
> 
> On Fri, Jul 27, 2001 at 08:30:53PM +1000, Neil Brown wrote:
> > On Friday July 27, puckwork@madz.net wrote:
> > > >> > > The URL is:
> > > >> >
> > > >> > > http://24.5.14.144:3000/linux-kernel
> > >
> > > http://keroon.dmz.dreampark.com:3000/linux-kernel/
> > >
> > > Can't be found (DNS-Error)
> 
> The problem is that the HTTP server on given IP address responds with
> its *name* in the URL. This means that $WEBBROWSER uses the name in
> its next connection attempt (-> load any given frame).
> 
> So one has to add "24.5.14.144 keroon.dmz.dreampark.com" to /etc/hosts
> to use it...
> 
> MfG, JBG
> 

If I use MSIE 5.5, from an external connection, it fails with a DNS
error. If I use Netscape 4.76 from the same machine, it all works fine.

Like I said, everything worked fine before I switched to this router
from my Linux router (I had 2 web servers running, one on this port, and
one on the usual port 80.)

Note that the server name in httpd.conf is 24.5.14.144 (I checked when
someone mentioned it), not keroon. I also notice in the log that
(apparently) some folks have no trouble, and others do.

All in all, it would work just fine if I uploaded to an external server
with a public IP/hostname, but my question still stands: Is it worth it
(using a newer kernel version of course)? There is over 1GB of HTML here
(that would take a while to U/L even on a cable modem :)

PGA

-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
