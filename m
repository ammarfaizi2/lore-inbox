Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287872AbSBDAHt>; Sun, 3 Feb 2002 19:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287886AbSBDAHj>; Sun, 3 Feb 2002 19:07:39 -0500
Received: from FORT-POINT-STATION.MIT.EDU ([18.7.7.76]:1972 "EHLO
	fort-point-station.mit.edu") by vger.kernel.org with ESMTP
	id <S287872AbSBDAHb>; Sun, 3 Feb 2002 19:07:31 -0500
Message-Id: <200202040007.TAA19301@multics.mit.edu>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Dan Kegel <dank@kegel.com>
cc: Arjen Wolfs <arjen@euro.net>, coder-com@undernet.org,
        feedback@distributopia.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork performance
In-Reply-To: Your message of "Sun, 03 Feb 2002 11:16:09 PST."
             <3C5D8C79.4C0792C5@kegel.com> 
Date: Sun, 03 Feb 2002 19:07:24 -0500
From: Kev <klmitch@MIT.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The /dev/epoll patch is good, but the interface is different enough
> from /dev/poll that ircd would need a new engine_epoll.c anyway.
> (It would look like a cross between engine_devpoll.c and engine_rtsig.c,
> as it would need to be notified by os_linux.c of any EWOULDBLOCK return values.
> Both rtsigs and /dev/epoll only provide 'I just became ready' notification,
> but no 'I'm not ready anymore' notification.)

I don't understand what it is you're saying here.  The ircu server uses
non-blocking sockets, and has since long before EfNet and Undernet branched,
so it already handles EWOULDBLOCK or EAGAIN intelligently, as far as I know.
-- 
Kevin L. Mitchell <klmitch@mit.edu>

