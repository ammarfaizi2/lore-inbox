Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282929AbRK0UX3>; Tue, 27 Nov 2001 15:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282932AbRK0UXK>; Tue, 27 Nov 2001 15:23:10 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:10248 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S282929AbRK0UWv>; Tue, 27 Nov 2001 15:22:51 -0500
Date: Tue, 27 Nov 2001 15:16:25 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Anuradha Ratnaweera <anuradha@gnu.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Release Policy [was: Linux 2.4.16  ]
In-Reply-To: <20011127134138.B21914@bee.lk>
Message-ID: <Pine.LNX.3.96.1011127150525.31174E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001, Anuradha Ratnaweera wrote:

> If I understand correctly, -preX releases will be for adding features and bug
> fixes and -rcX releases will be for only bug fixes.
> 
> Hopefully, there won't be _any_ change from last -rc release to the -final.

That certainly seems to be the usual way to do release candidates. For
ongoing enhancement, there can either be a freeze while the -rcN process
is happening, or the next -pre fixes can go against -rc1.

Example:

2.4.20-pre5 -> 2.4.20-rc1 -> 2.4.20-rc2 -(becomes)-> 2.4.20
                   \
              (also called)
                     \
                      \__ 2.4.21-pre0 -> 2.4.21-pre1 -> 2.4.21-pre2 -> ...

It all depends on the choice of the maintainer between holding off
addition of changes and slight increases in version numbering. Alan Cox
sort of "alternates," his releases are stable unless the ChangeLog says
otherwise. I've been using his release as "really stable" for some time,
although now I need patches which are never going to make it into the main
kernel AFAIK.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

