Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286935AbSBKDRp>; Sun, 10 Feb 2002 22:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286934AbSBKDRf>; Sun, 10 Feb 2002 22:17:35 -0500
Received: from courage.cs.stevens-tech.edu ([155.246.89.70]:45534 "HELO
	courage.cs.stevens-tech.edu") by vger.kernel.org with SMTP
	id <S286935AbSBKDRY>; Sun, 10 Feb 2002 22:17:24 -0500
Newsgroups: comp.os.linux.development.system
Date: Sun, 10 Feb 2002 22:17:19 -0500 (EST)
From: Marek Zawadzki <mzawadzk@cs.stevens-tech.edu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: TUN/TAP driver doesn't work.
In-Reply-To: <3C670CB4.7000005@tmsusa.com>
Message-ID: <Pine.NEB.4.33.0202102204200.21611-100000@courage.cs.stevens-tech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Feb 2002, J Sloan wrote:

> Have you successfully installed vtund and tun?

I just compiled my kernel with TUN=m support. I don't think I need
vtund.

> Make sure your kernel-headers package is newerthan 2.4.7

That was it - thanks! FYI - I upgraded my kernel-headers from 2.4.2-2 to
2.4.9-21 and recompiled pengaol and other software, which was using
TUN/TAP.
But it's pretty weird, though. Did they change values of #defines for
TUN/TAP ioctls' numbers, or what? If so, that's quite bad in my opinion
(what if somebody had binary-only version of his client?).

Anyway, once again thanks very much, Joe. This just proved that even
using crappy winmodem and the crappiest, most Windozed ISP ever (AOL) one
can succesfully rock with Linux ;-)

-marek


