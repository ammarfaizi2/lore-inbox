Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbTKQSKc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 13:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTKQSKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 13:10:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:29622 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263627AbTKQSK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 13:10:27 -0500
Date: Mon, 17 Nov 2003 10:05:20 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HOWTO build modules in 2.6.0 ...
Message-Id: <20031117100520.7b3b5529.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.58L.0311171939150.25906@alpha.zarz.agh.edu.pl>
References: <Pine.LNX.4.58L.0311171939150.25906@alpha.zarz.agh.edu.pl>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003 20:00:50 +0100 (CET) "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl> wrote:

| 
| Hi,
| 
| How can I build kernel modele from other package without root, or copying 
| all from /usr/scr/linux/ ??
| When I try build kernel module from user i got error,
| 
| [...]
| make[1]: Leaving directory `/users/cieciwa/rpm/BUILD/eagle-1.0.4/driver'
| /usr/bin/make -C /usr/src/linux SUBDIRS=`pwd` modules;
| make[1]: Entering directory `/usr/src/linux-2.6.0'
|   HOSTCC  scripts/fixdep
| cc1: Permission denied: opening dependency file scripts/.fixdep.d
| make[2]: *** [scripts/fixdep] Error 1
| make[1]: *** [scripts] Error 2
| make[1]: Leaving directory `/usr/src/linux-2.6.0'
| make: *** [adiusbadsl.o] Error 2
| make: Leaving directory `/users/cieciwa/rpm/BUILD/eagle-1.0.4/driver'
| 
| How can I solve this problem ??

Current kernel build requires a kernel source tree.
Given that, follow directions in linux/Documentation/kbuild/modules.txt
and .../makefiles.txt.
I have some working examples if you want pointers to them.

--
~Randy
MOTD:  Always include version info.
