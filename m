Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313358AbSDLEWq>; Fri, 12 Apr 2002 00:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313366AbSDLEWp>; Fri, 12 Apr 2002 00:22:45 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:13063 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313358AbSDLEWp>; Fri, 12 Apr 2002 00:22:45 -0400
Date: Fri, 12 Apr 2002 00:19:45 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <Pine.SOL.3.96.1020411235415.24708A-100000@virgo.cus.cam.ac.uk>
Message-ID: <Pine.LNX.3.96.1020412001417.7026A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2002, Anton Altaparmakov wrote:

> Considering modern harddrives have their own intelligent write back and
> sorting of write requests and ever growing hd buffers the need for doing
> this at the OS level is going to become less and less would be my guess, I
> may be wrong of course...

Clearly this is true. However, while the benefits of o/s effort are down
on top end hardware, one of the strengths of Linux is that it runs well on
small, or embedded, or old, or totally obsolete hardware. So there is a PR
and social benefit from the efforts already invested in making the code
use the hardware carefully.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

