Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbSKODmH>; Thu, 14 Nov 2002 22:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbSKODmH>; Thu, 14 Nov 2002 22:42:07 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:3851 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S265711AbSKODmF>; Thu, 14 Nov 2002 22:42:05 -0500
Date: Thu, 14 Nov 2002 22:51:48 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Moving from Linux 2.4.19 LVM to LVM2
In-Reply-To: <20021114082030.GB1061@reti>
Message-ID: <Pine.LNX.4.44.0211142247350.13759-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Joe Thornber wrote:

> On Wed, Nov 13, 2002 at 11:05:37PM -0500, Patrick Finnegan wrote:
> > Is there an easy and plainless way to do this?  Are the LVM2 tools
> > backwards-compatible with the old LVM?
>
> Yes

Actually, the answer is aparently "No."  LVM2's tools don't work with a
2.4.x kernel.  However, I since I was smart enough to stuff a backup copy
of the utilities into /root/lvm10.tar, 2.5.47 with the devicemapper patch
(so that it compiles properly) booted up just fine, first try.  Of course,
I needed to remember to load the "mousedev" module before X would work,
but that's not a kernel issue.

I'm fairly impressed with 2.5.x so far (once it compiled properly!).

Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu



