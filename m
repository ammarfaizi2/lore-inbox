Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277942AbRJRUOw>; Thu, 18 Oct 2001 16:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278118AbRJRUOm>; Thu, 18 Oct 2001 16:14:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13537 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277942AbRJRUOg>;
	Thu, 18 Oct 2001 16:14:36 -0400
Date: Thu, 18 Oct 2001 16:15:07 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: bill davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10
In-Reply-To: <200110182005.f9IK57506905@deathstar.prodigy.com>
Message-ID: <Pine.GSO.4.21.0110181612000.21021-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Oct 2001, bill davidsen wrote:

>   The change prevents use of stale data, and is a good one. mtools was a

Folks, could you please read the fucking source before discussing the
change that was not?

We had been flushing the cache upon final close() for quite a while; recent
changes come from something else and figuring out WTF had happened in 2.4.12
would be a Good Thing(tm).

