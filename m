Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267780AbTBRNOz>; Tue, 18 Feb 2003 08:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267791AbTBRNOz>; Tue, 18 Feb 2003 08:14:55 -0500
Received: from elixir.e.kth.se ([130.237.48.5]:53769 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S267780AbTBRNOz>;
	Tue, 18 Feb 2003 08:14:55 -0500
To: "Oliver Pitzeier" <o.pitzeier@uptime.at>
Cc: <axp-kernel-list@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Module problems (WAS: RE: 2.5.62 on Alpha SUCCESS (2.6 release soon!?))
References: <001401c2d74f$785bb720$020b10ac@pitzeier.priv.at>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 18 Feb 2003 14:24:52 +0100
In-Reply-To: "Oliver Pitzeier"'s message of "Tue, 18 Feb 2003 14:12:58 +0100"
Message-ID: <yw1xof59202j.fsf@bamse.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Oliver Pitzeier" <o.pitzeier@uptime.at> writes:

> > I just wanted to tell everybody that 2.5.62 works great for 
> > me on Alpha... Thanks a lot to the alpha kernel developers!!! 
> > You did a great job...
> [ ... ]
> 
> OK... Make modules_install still has problems:
> 
> [root@track linux]# make modules_install
> make -rR -f scripts/Makefile.modinst
>   mkdir -p /lib/modules/2.5.62/kernel/net/8021q; cp net/8021q/8021q.ko
> /lib/modules/2.5.62/kernel/net/8021q
>   mkdir -p /lib/modules/2.5.62/kernel/fs/autofs4; cp fs/autofs4/autofs4.ko
> /lib/modules/2.5.62/kernel/fs/autofs4
>   mkdir -p /lib/modules/2.5.62/kernel/drivers/net; cp drivers/net/bonding.ko
> /lib/modules/2.5.62/kernel/drivers/net
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.62; fi
> depmod: Unhandled relocation of type 10 for .text
> depmod: Unhandled relocation of type 10 for .text
> depmod: Unhandled relocation of type 10 for .text
> depmod: Unhandled relocation of type 10 for .text
> depmod: depmod obj_relocate failed

Which versions of binutils and gcc do you have?  I get similar
problems with binutils 2.13 and 2.4 kernels.

-- 
Måns Rullgård
mru@users.sf.net
