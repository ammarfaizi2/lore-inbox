Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261570AbTCGNUH>; Fri, 7 Mar 2003 08:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbTCGNUH>; Fri, 7 Mar 2003 08:20:07 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:1221 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S261570AbTCGNUG>;
	Fri, 7 Mar 2003 08:20:06 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15976.40680.424597.305633@gargle.gargle.HOWL>
Date: Fri, 7 Mar 2003 14:30:16 +0100
To: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Cc: perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       hardmeter-users@lists.sourceforge.jp
Subject: Re: [Perfctr-devel] perfctr and Linus' tree?
In-Reply-To: <20030307153354J.hyoshiok@miraclelinux.com>
References: <20030307153354J.hyoshiok@miraclelinux.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiro Yoshioka writes:
 > I have a question. Is there any progress on merging the
 > perfctr patch to Linus' kernel tree?
 > 
 > http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.0/0647.html
 > 
 > I found the DCL patch set includes the perfctr patch.
 > http://lists.osdl.org/pipermail/dcl_developer/2003-March/000009.html

No progress since Linus totally ignored it, but at least two
perfctr-patched trees exist. OSDL does one for the development
kernel, and Jack Perdue has pre-patched RedHat kernel .rpms.
(For Jack's stuff, check out PAPI -> Links -> Related Software.)

I'm planning to simplify the kernel <--> user-space interface in
perfctr-2.6 (drop /proc/pid/perfctr and go back to /dev/perfctr),
and then I _think_ I can do a version that doesn't require patching
kernel source. (It will do binary code patching at module load-time
instead. Horrible as that sounds, it's easier to deal with for users.)

/Mikael
