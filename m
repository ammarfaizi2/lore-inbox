Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277560AbRJOQAd>; Mon, 15 Oct 2001 12:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277556AbRJOQAX>; Mon, 15 Oct 2001 12:00:23 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:3031 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S277559AbRJOQAO>; Mon, 15 Oct 2001 12:00:14 -0400
Date: Mon, 15 Oct 2001 12:00:22 -0400
From: Chris Mason <mason@suse.com>
To: Hans-Peter Jansen <hpj@urpla.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount hanging 2.4.12
Message-ID: <90180000.1003161622@tiny>
In-Reply-To: <20011015153750.16F46F89@shrek.lisa.de>
In-Reply-To: <Pine.GSO.4.21.0110141231570.6026-100000@weyl.math.psu.edu> <2314290000.1003133922@tiny> <20011015153750.16F46F89@shrek.lisa.de>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, October 15, 2001 05:37:49 PM +0200 Hans-Peter Jansen <hpj@urpla.net> wrote:

> 
> Hi Chris,
> 
> I discovered some mount problems/hangs when playing with dvds,
> so I gave your patch a try, but it does not apply properly on 
> 2.4.12. Can you shred some light on this:

The patch was against 2.4.13-pre2 + lvm 1.0.1rc4, it is used for
journaled filesystem snapshots on lvm, so it should not help
the dvd case at all (sorry) .  It fixed Ed Tomlinson's problem because
he was using a buggy previous version of the patch.

-chris

