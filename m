Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273750AbRIXC6B>; Sun, 23 Sep 2001 22:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273749AbRIXC5v>; Sun, 23 Sep 2001 22:57:51 -0400
Received: from stanis.onastick.net ([207.96.1.49]:34565 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S273748AbRIXC5c>; Sun, 23 Sep 2001 22:57:32 -0400
Date: Sun, 23 Sep 2001 22:57:57 -0400
From: Disconnect <lkml@sigkill.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.10
Message-ID: <20010923225756.A2823@sigkill.net>
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <20010924032518.A8680@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010924032518.A8680@emma1.emma.line.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001, Matthias Andree did have cause to say:

> Well, if I run XFree86 4.1.0 (SuSE Linux 7.0 here, Diamond Viper V550
> (nVidia Riva TNT)) and switch to virtual text-mode tty (Ctrl Alt F1),
> hell freezes over. Screen turns black (but monitor syncs), machine is
> totally frozen. No Magic SysRq can help. Just Reset can. I use ext3fs on
> several partitions. 2.4.9 is fine, 2.4.9-ac7, -ac10 and 2.4.10 are
> broken.

Ditto here, at least as far back as 2.4.8-ac2 (nvidia driver blew up on
ac7 so I haven't tried anything more recent).

Tried to log out to reboot to 2.4.10+k7fix and logging out (X restarted)
triggered it.  (I have -got- to get to journalled root fs one of these
days.)

So you might look at 2.4.8 and 2.4.8-ac2, see whats changed.  No ext3
here, just ext2 and reiser+lvm.

(On a possibly unrelated note, 2.4.10 + k7fix works like a champ on the
iwill kk266 I've got, which was showing the athlon oops-on-boot bug.)

---
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P- L+++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t
5--- X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
