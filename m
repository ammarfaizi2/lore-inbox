Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbTFAWya (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 18:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264751AbTFAWya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 18:54:30 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:16367 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264228AbTFAWya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 18:54:30 -0400
Message-Id: <200306012300.h51N0AsG023776@ginger.cmf.nrl.navy.mil>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>, davem@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][ATM] assorted he driver cleanup 
In-reply-to: Your message of "01 Jun 2003 21:00:15 BST."
             <1054497613.5863.4.camel@dhcp22.swansea.linux.org.uk> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Sun, 01 Jun 2003 18:58:26 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-6.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1054497613.5863.4.camel@dhcp22.swansea.linux.org.uk>,Alan Cox writes:
>> but on a single processor machine (i.e. #undef CONFIG_SMP) there is no
>> chance that there will be reads/writes from other processors so i dont
>> need any locking OR protection from interrupts.  so the degenerate case
>> of spin_lock_irqsave() isnt quite as dengerate as i would like for this
>> particular spin lock.
>
>Then why are you using spin_lock_irqsave ?

meaning just use spin_lock() or what?
