Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310737AbSCMQDP>; Wed, 13 Mar 2002 11:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310703AbSCMQDF>; Wed, 13 Mar 2002 11:03:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64018 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310695AbSCMQCx>; Wed, 13 Mar 2002 11:02:53 -0500
Subject: Re: [PATCH] Support for assymmetric SMP
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 13 Mar 2002 16:17:52 +0000 (GMT)
Cc: andrea@suse.de (Andrea Arcangeli), garloff@suse.de (Kurt Garloff),
        linux-kernel@vger.kernel.org (Linux kernel list),
        sekharan@us.ibm.com (S. Chandra Sekharan)
In-Reply-To: <m13cz5zv00.fsf@frodo.biederman.org> from "Eric W. Biederman" at Mar 12, 2002 08:05:51 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lBRo-0006jU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > irq always to the same cpu for several seconds. I know the probability
> > for that to happen is low but it can happen.
> 
> Actually I know of at least one dual P4 Xeon board where I haven't seen anything
> except IPI go to the second cpu.

Expect that to occur. The random distribution stuff doesn't seem to be a
feature of all pentium IV systems. Ie this bug does want fixing
