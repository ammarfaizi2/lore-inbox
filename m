Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVA3QpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVA3QpY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 11:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVA3QpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 11:45:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:47567 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261724AbVA3QpN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 11:45:13 -0500
Subject: Re: Deadlock in serial driver 2.6.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin =?ISO-8859-1?Q?K=F6gler?= <e9925248@student.tuwien.ac.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050126231329.440fbcd8.akpm@osdl.org>
References: <20050126132047.GA2713@stud4.tuwien.ac.at>
	 <20050126231329.440fbcd8.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1106844084.14782.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 30 Jan 2005 15:39:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-27 at 07:13, Andrew Morton wrote:
> Martin Kögler <e9925248@student.tuwien.ac.at> wrote:
> (For some reason the NMI watchdog isn't triggering here, and it's still
> taking interrupts).

> Looks like low-latency mode is busted.

low latency mode is fine, the drivers/serial layer is busted. It workd
fine with non drivers/serial using hardware still, and it worked fine in
2.4


