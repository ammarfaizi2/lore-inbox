Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262663AbTCIXEB>; Sun, 9 Mar 2003 18:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbTCIXEB>; Sun, 9 Mar 2003 18:04:01 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:27407
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S262663AbTCIXD6>; Sun, 9 Mar 2003 18:03:58 -0500
Subject: Re: Kernel bug in dcache.h:266; 2.5.64, EIP at sysfs_remove_dir
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Tomasz Torcz, BG" <zdzichu@irc.pl>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.33.0303091604530.994-100000@localhost.localdomain>
References: <Pine.LNX.4.33.0303091604530.994-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1047251674.1418.1.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 09 Mar 2003 15:14:34 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-09 at 14:06, Patrick Mochel wrote:
> Bah, we're accidentally dropping the refcount on the directory one too 
> many times, which is a different, though slightly related, problem to the 
> one the previous patch fixed. 
> 
> Please try this patch (after removing the previous one).

That looks like it fixed it.

	J

