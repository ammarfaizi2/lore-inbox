Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUISUFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUISUFd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 16:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUISUFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 16:05:33 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:19081 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S263100AbUISUF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 16:05:28 -0400
Date: Mon, 20 Sep 2004 00:05:27 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2 hangs in posix_locks_deadlock
Message-ID: <20040919200527.GA7184@tentacle.sectorb.msk.ru>
References: <20040919160342.GA26409@tentacle.sectorb.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20040919160342.GA26409@tentacle.sectorb.msk.ru>
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.6.9-rc2
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2004 at 08:03:42PM +0400, Vladimir B. Savkin wrote:
> I was experiencing kernel hangs with versions 2.6.9-rc2 and
> 2.6.9-rc2-mm1 on two different boxes.

FYI: I have reverted posix-locking-* patches (as found in 2.6.9-rc2-mm1
patch set), no hangs since that. 

> 
> Today I managed to see the output of Alt+SysRq+P on the
> hanged box and write down call trace (from screen, so it is incomplete).
> 
> EIP (c015da89) was in function posix_locks_deadlock,
> and the call trace was:
>  __posix_lock_file
>  fcntl_setlk
~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

