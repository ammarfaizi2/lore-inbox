Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262999AbSJBIQw>; Wed, 2 Oct 2002 04:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263000AbSJBIQw>; Wed, 2 Oct 2002 04:16:52 -0400
Received: from [210.19.28.13] ([210.19.28.13]:39637 "HELO gateway.vault-id.com")
	by vger.kernel.org with SMTP id <S262999AbSJBIQv>;
	Wed, 2 Oct 2002 04:16:51 -0400
Message-ID: <33721.10.2.16.178.1033546953.squirrel@mail.Vault-ID.com>
Date: Wed, 2 Oct 2002 16:22:33 +0800 (MYT)
Subject: Re: 2.5.40 compile error (missing imm.o)
From: "Corporal Pisang" <Corporal_Pisang@Counter-Strike.com.my>
To: <linux-kernel@vger.kernel.org>
X-XheaderVersion: 1.1
X-UserAgent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20020923 Phoenix/0.1
In-Reply-To: <E17wdvf-0005YV-00@laibach.mweb.co.za>
References: <E17wdvf-0005YV-00@laibach.mweb.co.za>
X-Priority: 3
Importance: Normal
Reply-To: Corporal_Pisang@Counter-Strike.com.my
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Try this patch I think it should fix it (not tested though)

your patch makes the compilation start again, and no problem till the end
at make modules_install

make modules_install produce this error:


if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.40; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.40/kernel/fs/xfs/xfs.o
depmod:         run_task_queue
depmod:         TQ_ACTIVE
depmod:         queue_task
depmod: *** Unresolved symbols in
/lib/modules/2.5.40/kernel/net/ipv4/netfilter/ipt_owner.o
depmod:         next_thread
depmod:         find_task_by_pid
depmod: *** Unresolved symbols in
/lib/modules/2.5.40/kernel/net/ipv6/netfilter/ip6t_owner.o
depmod:         next_thread
depmod:         find_task_by_pid


Regards

-Ubaida-



