Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbTJCKav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 06:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbTJCKav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 06:30:51 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:19219 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263691AbTJCKas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 06:30:48 -0400
Date: Fri, 3 Oct 2003 12:30:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "J.A. Magallon" <jamagallon@able.es>
cc: linux-hfsplus-devel@lists.sourceforge.net, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] new HFS(+) driver
In-Reply-To: <20031003070422.GA8627@werewolf.able.es>
Message-ID: <Pine.LNX.4.44.0310031227460.17548-100000@serv>
References: <Pine.LNX.4.44.0310021029110.17548-100000@serv>
 <20031003070422.GA8627@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 3 Oct 2003, J.A. Magallon wrote:

> Two notes:
> - You should give a patch or at least give a notice that linux/include/hfs* have
>   to be killed (or move hfs_fs.h there).

You did apply linux-2.4.hfs.diff? I don't understand why you had to move 
hfs_fs.h, it should be picked up from the current directory.

> - I had to include linux/sched.h in hfs/sysdep.c to get the definition for
>   'current', that was neded in some subinclude of linux/smp_lock. This can be
>   caused by any other of my patches, but it doesn't hurt.

Simply move <linux/smp_lock.h> past "hfs_fs.h".

bye, Roman

