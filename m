Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUISUge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUISUge (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 16:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUISUge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 16:36:34 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:61579 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S263770AbUISUgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 16:36:20 -0400
Date: Mon, 20 Sep 2004 00:36:19 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2 hangs in posix_locks_deadlock
Message-ID: <20040919203619.GA8618@tentacle.sectorb.msk.ru>
References: <20040919160342.GA26409@tentacle.sectorb.msk.ru> <20040919200527.GA7184@tentacle.sectorb.msk.ru> <1095625531.7860.59.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1095625531.7860.59.camel@lade.trondhjem.org>
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.6.9-rc2
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2004 at 01:32:08PM -0700, Trond Myklebust wrote:
> P? su , 19/09/2004 klokka 13:05, skreiv Vladimir B. Savkin:
> > > 
> > > Today I managed to see the output of Alt+SysRq+P on the
> > > hanged box and write down call trace (from screen, so it is incomplete).
> > > 
> > > EIP (c015da89) was in function posix_locks_deadlock,
> > > and the call trace was:
> > >  __posix_lock_file
> > >  fcntl_setlk
> 
> What filesystems are you using on that box?

reiserfs on all but / and /boot partitions, which are ext2.

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

