Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266859AbSKWC2U>; Fri, 22 Nov 2002 21:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbSKWC2U>; Fri, 22 Nov 2002 21:28:20 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:54539 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S266859AbSKWC2U>; Fri, 22 Nov 2002 21:28:20 -0500
Date: Sat, 23 Nov 2002 02:35:13 +0000
From: John Levon <levon@movementarian.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New module loader makes kernel debugging much harder
Message-ID: <20021123023513.GC83190@compsoc.man.ac.uk>
References: <13542.1038018010@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13542.1038018010@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18FQ8a-000O6e-00*PgLP/lv/tqE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2002 at 01:20:10PM +1100, Keith Owens wrote:

> The complete lack of kernel and module symbols (no /proc/ksyms) means
> that ksymoops is now useless on 2.5 kernels.  If you get an oops in a
> kernel built without kksymoops, there is no way to decode the oops.

Additionally, module profiling is not possible any more.

> Big step backwards, Rusty.

Somebody (this includes Rusty himself) needs to come up with a workable
solution. For my own needs, the start address of the mapped module is
good enough, but it seems you need more than that. I'd be quite happy
with the re-introduction of /proc/ksyms as it would mean no userspace
code changes for me :)

regards
john

-- 
Khendon's Law: If the same point is made twice by the same person,
the thread is over.
