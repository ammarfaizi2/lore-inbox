Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261429AbTCGHcU>; Fri, 7 Mar 2003 02:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261430AbTCGHcU>; Fri, 7 Mar 2003 02:32:20 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:20363
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261429AbTCGHcT>; Fri, 7 Mar 2003 02:32:19 -0500
Date: Fri, 7 Mar 2003 02:40:46 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oops: 2.5.64 check_obj_poison for 'size-64'
In-Reply-To: <20030306233517.68c922f9.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50.0303070239040.18716-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303062358130.17080-100000@montezuma.mastecende.com>
 <20030306222328.14b5929c.akpm@digeo.com>
 <Pine.LNX.4.50.0303070221470.18716-100000@montezuma.mastecende.com>
 <20030306233517.68c922f9.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, Andrew Morton wrote:

> OK.  -mm has a more sophisticated use-after-free detector.  It might be
> worth dropping that in there, see if we can get more info.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.64/2.5.64-mm1/broken-out/use-after-free-check.patch

Ok i'll drop that in and leave it to run for a bit.

> OK, thanks.
> 
> All the arch/*/kernel/irq.c implementations are distressingly similar. 
> Andrey Panin did a bunch of work a while back to start consolidating the
> common code but it didn't quite get finished off.  Guess we just have to grit
> our teeth for now.

Possibly didn't continue due to lack of feedback, i think he had 
personally tested most i386 combos.

	Zwane
-- 
function.linuxpower.ca
