Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130428AbRCGHyZ>; Wed, 7 Mar 2001 02:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130429AbRCGHyP>; Wed, 7 Mar 2001 02:54:15 -0500
Received: from mta02.mail.au.uu.net ([203.2.192.82]:7072 "EHLO
	mta02.mail.mel.aone.net.au") by vger.kernel.org with ESMTP
	id <S130428AbRCGHx6>; Wed, 7 Mar 2001 02:53:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Matt Johnston <mlkm2@caifex.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac13 make modules_install error
Date: Wed, 7 Mar 2001 15:54:02 +0800
X-Mailer: KMail [version 1.2.1]
In-Reply-To: <381411025.983941453617.JavaMail.root@web124-wra.mail.com>
In-Reply-To: <381411025.983941453617.JavaMail.root@web124-wra.mail.com>
MIME-Version: 1.0
Message-Id: <01030715540200.00284@box.caifex.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've had the same problem, it also happens in 2.4.2ac12

Cheers,
Matt Johnston



On Wed,  7 Mar 2001 13:04, Frank Davis wrote:
> Hello,
>    While 'make modules_install' on 2.4.2-ac13, I receive the following
> error:
>
> make -C kernel modules_install
> make[1]: Entering directory '/usr/src/linux/kernel'
> make[1]: Nothing to be done for 'modules_install'.
> ..
> make -C drivers modules_install
> make[1]: Entering directory ;/usr/src/linux/drivers'
> make -C arm modules_install
> make[2]: Entering directory '/usr/src/linux/drivers/atm'
> mkdir -p /lib/modules/2.4.2-ac13/kernel/$(shell ($CONFIG_SHELL)
> $(TOPDIR)/scripts/pathdown.sh) /bin/sh: CONFIG_SHELL: command not found
> /bin/sh: TOPDIR: command not found
> ....
>
> All previous steps appeared to work without any problems, and I performed a
> 'make mrproper'. The build worked in 2.4.2-ac11 . Any suggestions?
>
> Regards,
> Frank
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
