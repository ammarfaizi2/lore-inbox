Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272729AbTG1Ibq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 04:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272740AbTG1Ibp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 04:31:45 -0400
Received: from pluvier.ens-lyon.fr ([140.77.167.5]:20369 "EHLO
	mailhost.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S272729AbTG1Ibn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 04:31:43 -0400
Date: Mon, 28 Jul 2003 10:46:57 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2 - UML compile error
Message-ID: <20030728084657.GE23898@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just downloaded 2.6.0-test2, make defconfig ARCH=um
and make linux ARCH=um
[...]
  CC      arch/um/util/mk_task_kern.o
In file included from include/asm/system-generic.h:4,
                 from include/asm/system.h:4,
		 from include/linux/list.h:8,
	         from include/linux/signal.h:4,
	         from include/asm/processor-generic.h:14,
        	 from include/asm/processor.h:22,
	         from include/asm/thread_info.h:11,
		 from include/linux/thread_info.h:21,
	         from include/linux/spinlock.h:12,
		 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
	         from arch/um/util/mk_task_kern.c:1:
include/asm/arch/system.h:7: asm/cpufeature.h: No such file or directory
make[1]: *** [arch/um/util/mk_task_kern.o] Erreur 1
make: *** [arch/um/util] Erreur 2

Regards.
-- 
Brice Goglin
================================================
Ph.D Student
Laboratoire de l'Informatique et du Parallélisme
CNRS-INRIA-ENS Lyon
France
