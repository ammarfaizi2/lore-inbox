Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268126AbUI2Ay4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268126AbUI2Ay4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 20:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268131AbUI2Awi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 20:52:38 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:12937 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268126AbUI2Avw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 20:51:52 -0400
Subject: Re: mlock(1)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Stefan Seyfried <seife@suse.de>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Chris Wright <chrisw@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
In-Reply-To: <20040927141652.GF28865@dualathlon.random>
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net>
	 <1096071873.3591.54.camel@desktop.cunninghams>
	 <20040925011800.GB3309@dualathlon.random> <4157B04B.2000306@suse.de>
	 <20040927141652.GF28865@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096291898.9911.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Sep 2004 14:31:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-27 at 15:16, Andrea Arcangeli wrote:
> because I never use suspend/resume on my desktop, I never shutdown my
> desktop. I don't see why should I spend time typing a password when
> there's no need to. Every single guy out there will complain at linux
> hanging during boot asking for password before reaching kdm.

So attempt a decrypt with a null password before asking. 

> > And a resume is - in the beginning - a boot, so just ask early enough
> > (maybe the bootloader could do this?)

We are very limited as to which bits the bootloader can do
unfortunately.
