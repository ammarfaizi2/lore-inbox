Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269029AbUISQDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269029AbUISQDr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 12:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269261AbUISQDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 12:03:47 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:17846 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S269029AbUISQDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 12:03:43 -0400
Date: Sun, 19 Sep 2004 20:03:42 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc2 hangs in posix_locks_deadlock
Message-ID: <20040919160342.GA26409@tentacle.sectorb.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
X-Organization: Moscow State Univ., Dept. of Mechanics and Mathematics
X-Operating-System: Linux 2.6.8-rc3-barrier
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was experiencing kernel hangs with versions 2.6.9-rc2 and
2.6.9-rc2-mm1 on two different boxes.

Today I managed to see the output of Alt+SysRq+P on the
hanged box and write down call trace (from screen, so it is incomplete).

EIP (c015da89) was in function posix_locks_deadlock,
and the call trace was:
 __posix_lock_file
 fcntl_setlk


Offending process was saslauthd (version 2.1.15)

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

