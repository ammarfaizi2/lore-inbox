Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBHMT1>; Thu, 8 Feb 2001 07:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRBHMTR>; Thu, 8 Feb 2001 07:19:17 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:4359 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129032AbRBHMTI>; Thu, 8 Feb 2001 07:19:08 -0500
Date: Thu, 8 Feb 2001 07:19:15 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
cc: Matt Bernstein <matt@theBachChoir.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: increasing the 512 process limit at run-time?
In-Reply-To: <Pine.LNX.4.32.0102070439520.15577-100000@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.4.33.0102080716540.5431-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001, Mr. James W. Laferriere wrote:

>Date: Wed, 7 Feb 2001 04:43:19 -0800 (PST)
>From: Mr. James W. Laferriere <babydr@baby-dragons.com>
>To: Matt Bernstein <matt@theBachChoir.org.uk>
>Cc: linux-kernel@vger.kernel.org
>Content-Type: TEXT/PLAIN; charset=US-ASCII
>Subject: Re: increasing the 512 process limit at run-time?
>
>
>	Hello Matt ,  At what uptime does one hit this limit ?
>uptime
>  4:40am  up 444 days, 12:58,  1 user,  load average: 0.00, 0.00, 0.00
>uname -a
>Linux filesrv2 2.2.6 #1 SMP Thu Jul 1 20:33:30 PDT 1999 i686 unknown
>
>	Not that that is anything spectacular , just looking for
>	rough idea of uptime before hitting the NR_TASKS limit .
>		Tia ,  JimL

The NR_TASKS is the maximum number of simultaneous running
processes in the system and has nothing at all to do whatsoever
with the uptime.

In 2.2.x NR_TASKS is set in stone during compile time.  If you
need more simultaneous tasks you must recompile with NR_TASKS set
higher.  You can set it as high as 4090 or so (read the docs).

In 2.4.x it can be set via proc at runtime.

Again, uptime means absolutely nothing.

----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
If you're interested in computer security, and want to stay on top of the
latest security exploits, and other information, visit:

http://www.securityfocus.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
