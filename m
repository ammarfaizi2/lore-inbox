Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSFVUun>; Sat, 22 Jun 2002 16:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316798AbSFVUun>; Sat, 22 Jun 2002 16:50:43 -0400
Received: from [213.4.129.129] ([213.4.129.129]:63663 "EHLO tsmtp3.ldap.isp")
	by vger.kernel.org with ESMTP id <S316608AbSFVUum>;
	Sat, 22 Jun 2002 16:50:42 -0400
Date: Sat, 22 Jun 2002 22:52:29 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: piggy broken in 2.5.24 build
Message-Id: <20020622225229.46805a91.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.44.0206221501430.7338-100000@chaos.physics.uiowa.edu>
References: <3D14B6DA.7090609@hotmail.com>
	<Pine.LNX.4.44.0206221501430.7338-100000@chaos.physics.uiowa.edu>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a question about kbuild behaviour:

I compiled 2.5.24, with make dep, make bzImage, make modules....
After that, as usually, make dep; make bzImage ...doesn't change nor
recompile anything After that, I changed an option with menuconfig,
"VGA 16-color graphics console support",and "3DFX Banshee/Voodoo 3
display support" (because i can't see somethnig when i boot with it)
from built-in to module. Then I run make dep; and it did make some small
changes, as expected.


Then make bzImage compiled the entier kernel again, or at less a big big
part of it, not only the changes made in menuconfig. make modules
recompiled things again, wich are not affected with the changes (ie:
iptables modules).

My questions is:

It's not expected to do the same as 2.4 kernels, i mean, recompile only
the changes made, not the entire thing?


PD: What are you doing with kbuild 2.5? What parts are you integrating?
Wich parts you aren't going to integrate?
