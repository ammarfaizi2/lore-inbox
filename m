Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261860AbTCZSlu>; Wed, 26 Mar 2003 13:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261862AbTCZSlu>; Wed, 26 Mar 2003 13:41:50 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62726 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261860AbTCZSlt>; Wed, 26 Mar 2003 13:41:49 -0500
Date: Wed, 26 Mar 2003 13:47:04 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: jds <jds@soltis.cc>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems when boot new kernel 2.5.66 kernel panic
In-Reply-To: <20030325190214.M66226@soltis.cc>
Message-ID: <Pine.LNX.3.96.1030326134208.8246B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003, jds wrote:

> Hi my name is Jesus Delgado from Mexico City:
> 
>   I need help for resolve this problems, compile kernel 2.5.66 in rh 8, update
> my lvm to lvm2 utils, devmapper, modutil 2.4.24, when try to boot with new
> kernel recive this messages:

I think you have the old modutils unless Rusty changed the version numbers
drastically. From memory they are somewhere in
  ftp:ftp.kernel.org/pub/linux/kernel/people/rusty

However, your problem *might* be initrd if the drivers are not all built
in. The stock Redhat mkinitrd called by "make install" doesn't seem to
work, and Rusty has stated he has no intentions of providing a working
one. I'm told there's a new mkinitrd at Redhat, but I haven't found it (or
even looked very hard).

If you are building it all in I can't help.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

