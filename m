Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269205AbTCBNSs>; Sun, 2 Mar 2003 08:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269206AbTCBNSs>; Sun, 2 Mar 2003 08:18:48 -0500
Received: from [66.70.28.20] ([66.70.28.20]:49681 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S269205AbTCBNSq>; Sun, 2 Mar 2003 08:18:46 -0500
Date: Sun, 2 Mar 2003 13:51:26 +0100
From: DervishD <raul@pleyades.net>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
Message-ID: <20030302125126.GG45@DervishD>
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E5C8682.F5929A04@daimi.au.dk>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Kasper :)

 Kasper Dupont dixit:
> Some more interesting cases are loopback mounts and bind mounts,
> in which case the device field is completely different.
[...]
> (And since I remember remount
> bugs in tmpfs in early 2.4 kernels, it is not going to get easier
> to put more requirements on the filesystem.)

    Not an easy fix, then. I've read the thread that this message
originated, and I think that the better solucion, in the short term I
mean, is to symlink /etc/mtab to a proper writeable place in the
filesystem. Anyway, I think that this kind of 'traditional' things
should go away and better solutions used instead. My particular
problem is that *I* don't have better solutions (at least
implemented...).

    Thanks a lot for the interest :)
    Raúl
