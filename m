Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264626AbSIWAQV>; Sun, 22 Sep 2002 20:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbSIWAQV>; Sun, 22 Sep 2002 20:16:21 -0400
Received: from u212-239-154-82.freedom.planetinternet.be ([212.239.154.82]:2564
	"EHLO jebril.pi.be") by vger.kernel.org with ESMTP
	id <S264626AbSIWAQV>; Sun, 22 Sep 2002 20:16:21 -0400
Message-Id: <200209230019.g8N0JmvC003642@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.38 
In-Reply-To: Your message of "Sat, 21 Sep 2002 21:34:18 PDT."
             <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com> 
Date: Mon, 23 Sep 2002 02:19:48 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Trying to be a bit more timely about releases, especially since some 
> people couldn't use 2.5.37 due to the X lockup that should hopefully
> be fixed (no idea _why_ that old bug only started to matter recently, the 
> bug itself was several months old).

The boot time lock up, that I have indeed encountered intermittently ever 
since switching to 2.5.3{01}, may indeed be gone, but the one where just 
moving my mouse around locks things up in a matter of seconds hasn't. 
This started somewhere in 2.5.3{234}, only the latter of which I was able 
to compile for my box.

Someone recently reported having similar problems and fixing them by 
disabling MTRR, but this cannot be the entire story since I never had it 
enabled in the first place. No wonder, on a dual P5 machine...

By the way, 2.3.38 gives me this:

depmod: *** Unresolved symbols in /lib/modules/2.5.38/kernel/net/ipv4/netfilter/ipt_owner.o
depmod:         find_task_by_pid

Regards,

MCE
