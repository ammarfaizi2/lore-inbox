Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272748AbTG1IjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 04:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272750AbTG1IiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 04:38:21 -0400
Received: from outmail.cc.huji.ac.il ([132.64.1.21]:45033 "EHLO
	mail3.cc.huji.ac.il") by vger.kernel.org with ESMTP id S272748AbTG1Ihx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 04:37:53 -0400
Message-ID: <3F24D937.4050905@mscc.huji.ac.il>
Date: Mon, 28 Jul 2003 11:05:11 +0300
From: Voicu Liviu <pacman@mscc.huji.ac.il>
Organization: Hebrew University of Jerusalem
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030713
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 - UML compile error
References: <20030728084657.GE23898@ens-lyon.fr>
In-Reply-To: <20030728084657.GE23898@ens-lyon.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.2(snapshot 20021217) (pluto.mscc.huji.ac.il)
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.14; VAE: 6.20.0.1; VDF: 6.20.0.26; host: mail3.cc.huji.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin wrote:
> Hi,
> 
> I just downloaded 2.6.0-test2, make defconfig ARCH=um
> and make linux ARCH=um
> [...]
>   CC      arch/um/util/mk_task_kern.o
> In file included from include/asm/system-generic.h:4,
>                  from include/asm/system.h:4,
> 		 from include/linux/list.h:8,
> 	         from include/linux/signal.h:4,
> 	         from include/asm/processor-generic.h:14,
>         	 from include/asm/processor.h:22,
> 	         from include/asm/thread_info.h:11,
> 		 from include/linux/thread_info.h:21,
> 	         from include/linux/spinlock.h:12,
> 		 from include/linux/capability.h:45,
>                  from include/linux/sched.h:7,
> 	         from arch/um/util/mk_task_kern.c:1:
> include/asm/arch/system.h:7: asm/cpufeature.h: No such file or directory

It seems that header is missing?!

> make[1]: *** [arch/um/util/mk_task_kern.o] Erreur 1
> make: *** [arch/um/util] Erreur 2
> 
> Regards.


-- 
Voicu Liviu
Rothberg International School
Computation center, Mount Scopus
Hebrew University of Jerusalem
Tel: 972(2)-5881253
E-mail: pacman@mscc.huji.ac.il

Operating System: Linux Gentoo1.4 ( www.gentoo.org )

Click here to see my GPG signature:
	http://search.keyserver.net:11371/pks/lookup?template=netensearch%2Cnetennomatch%2Cnetenerror&search=pacman%40mscc.huji.ac.il&op=vindex&fingerprint=on&submit=Get+List

