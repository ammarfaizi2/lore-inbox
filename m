Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129228AbQKYNtE>; Sat, 25 Nov 2000 08:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129434AbQKYNsp>; Sat, 25 Nov 2000 08:48:45 -0500
Received: from jalon.able.es ([212.97.163.2]:59335 "EHLO jalon.able.es")
        by vger.kernel.org with ESMTP id <S129228AbQKYNsn>;
        Sat, 25 Nov 2000 08:48:43 -0500
Date: Sat, 25 Nov 2000 14:18:30 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Keith Owens <kaos@ocs.com.au>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
        "Matt D . Robinson" <yakker@alacritech.com>
Subject: Re: LKCD from SGI
Message-ID: <20001125141830.C2877@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <m1ofz5vszh.fsf@frodo.biederman.org> <5009.975117517@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <5009.975117517@ocs3.ocs-net>; from kaos@ocs.com.au on Sat, Nov 25, 2000 at 02:58:37 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 25 Nov 2000 02:58:37 Keith Owens wrote:
> 
> 2.5 kernel build wish list[1] has a couple of entries for standardising
> the install targets.  My thinking (and I know that some people disagree
> with this) is that the standard targets of a linux compile are only
> 
> * vmlinux
> * System.map
> * modules in the kernel tree (not installed yet)
> * any other bits and pieces that are required to compile external
>   modules against this config.
> 

Could the default target install names int the std kernel be changed to 
System.map -> System.map-$(KERNELRELEASE)
vmlinuz    -> vmlinuz-$(KERNELRELEASE)
and then symlink to that ?

I think everyone that has a stable2.2, a devel 2.2 and a test24 is using that
method, so as many distros...

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux 2.2.18-pre23-vm #3 SMP Wed Nov 22 22:33:53 CET 2000 i686 unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
