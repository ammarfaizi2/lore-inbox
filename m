Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131344AbRDBVmK>; Mon, 2 Apr 2001 17:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131349AbRDBVlv>; Mon, 2 Apr 2001 17:41:51 -0400
Received: from jalon.able.es ([212.97.163.2]:55271 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131344AbRDBVlr>;
	Mon, 2 Apr 2001 17:41:47 -0400
Date: Mon, 2 Apr 2001 23:40:45 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, David Lang <dlang@diginsite.com>,
   Manfred Spraul <manfred@colorfullife.com>,
   "Albert D . Cahalan" <acahalan@cs.uml.edu>, lm@bitmover.com,
   linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
Message-ID: <20010402234045.C17148@werewolf.able.es>
In-Reply-To: <Pine.LNX.3.96.1010401181724.28121i-100000@mandrakesoft.mandrakesoft.com> <Pine.LNX.4.30.0104021436110.24812-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.30.0104021436110.24812-100000@waste.org>; from oxymoron@waste.org on Mon, Apr 02, 2001 at 21:39:55 +0200
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.02 Oliver Xymoron wrote:
> 
> As a former proponent of /proc/config (I wrote one of the much-debated
> patches), I tend to agree. Debian's make-kpkg does the right thing, namely
> treating .config the same way it treats System-map, putting it in the
> package and eventually installing it in /boot/config-x.y.z. If Redhat's
> kernel-install script did the same it would rapidly become a non-issue.
> 

Could <installkernel> make part of the kernel scripts, or in one other
standard software package, like modutils, so its versions are controlled
and can be requested (in Doc/ChageLog, like other things) ?

Perhaps it could be put into a kernel-utils package with ksymoops, and
standarise the places and naming. I do not know if systems like Caldera,
SuSE or Debian adopted the /boot place for kernel things (standard kernels
still come with INSTALL_PATH=/boot commented-out), or the
vmlinuz-X.Y.Z naming.

I think the best solution would be to make /boot the 'official' place for
kernels, the -X.Y.Z naming an standard, installkernel should save System.map
and .config.

And you can add something like /proc/signature/map, /proc/signature/config,
etc to md5-check if a certain file fits running kernel.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3 #2 SMP Fri Mar 30 15:42:05 CEST 2001 i686

