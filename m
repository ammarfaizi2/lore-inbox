Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293118AbSBQOgf>; Sun, 17 Feb 2002 09:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293119AbSBQOgZ>; Sun, 17 Feb 2002 09:36:25 -0500
Received: from [66.150.46.254] ([66.150.46.254]:40749 "EHLO mail.tvol.net")
	by vger.kernel.org with ESMTP id <S293118AbSBQOgO>;
	Sun, 17 Feb 2002 09:36:14 -0500
Message-ID: <3C6FBFD7.238F8915@wgate.com>
Date: Sun, 17 Feb 2002 09:36:07 -0500
From: Michael Sinz <msinz@wgate.com>
Organization: WorldGate Communications Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; FreeBSD 4.5-STABLE i386)
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Core dump file control
In-Reply-To: <200202161737.g1GHbkJh001254@tigger.cs.uni-dortmund.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> Michael Sinz <msinz@wgate.com> said:
> > I have, for a long time, wished that Linux had a way to specify where
> > core dumps are stored
> 
> CWD (chdir(2))

So, all of my applications and support programs should run with their
CWD set to /coredumps?  I don't want to flame here, but "get real".

That is almost as good as saying that to get security you just need to
make sure no one bad is using your system.

> >                       and what the name of the core dump is.
> 
> /proc/sys/kernel/core_uses_pid

Well, this does make unique file names, almost.  But it does not really
identify the file.  Plus, in a cluster of machines, many of them have
the same PIDs.  (Say, 100 machines, you get 100 of each PID)

-- 
Michael Sinz ---- Blackdown Java -- http://www.sinz.org/Michael.Sinz
Michael Sinz ---- Worldgate Communications ---- msinz@wgate.com
A master's secrets are only as good as
	the master's ability to explain them to others.
