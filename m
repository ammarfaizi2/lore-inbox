Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279980AbRKIQZs>; Fri, 9 Nov 2001 11:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279983AbRKIQZi>; Fri, 9 Nov 2001 11:25:38 -0500
Received: from [139.84.194.100] ([139.84.194.100]:59275 "EHLO
	eclipse.pheared.net") by vger.kernel.org with ESMTP
	id <S279980AbRKIQZ3>; Fri, 9 Nov 2001 11:25:29 -0500
Date: Fri, 9 Nov 2001 11:25:08 -0500 (EST)
From: Kevin <kevin@pheared.net>
To: Thomas Braun <nospam@link-up.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oops/Aiee in 2.4.14 when unloading PCMCIA modules
In-Reply-To: <200111091611.QAA26283@dix.eb.de>
Message-ID: <Pine.GSO.4.40.0111091122550.10770-100000@eclipse.pheared.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2001, Thomas Braun wrote:

[nospam] Hi,
[nospam]
[nospam] I get an oops every time when I stop PCMCIA with
[nospam]     cardctl eject; killproc /sbin/cardmgr; lsmod
[nospam] With a "sleep 2" before lsmod it does not happen. I tried kernel
[nospam] 2.4.1[34] with modutils 2.4.{2,10}, pcmcia-cs-3.1.29.

Thomas, I can verify a similar problem.  I'm running 2.4.15-pre1 with
pcmcia-3.1.29, not built into the kernel.  The only difference with my
setup is that it only seems to happen if I eject both cards at the same
time or do other pcmcia card acrobatics.  If I do one at a time, there
doesn't appear to be a problem.

-[ kevin@pheared.net                 devel.pheared.net ]-
-[ Rather be forgotten, than remembered for giving in. ]-
-[ ZZ = g ^ (xb * xa) mod p      g = h^{(p-1)/q} mod p ]-

