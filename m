Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVAPWPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVAPWPT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVAPWPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:15:19 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41093 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262627AbVAPWPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:15:14 -0500
Subject: Re: User space out of memory approach
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Edjard Souza Mota <edjard@gmail.com>
Cc: Ilias Biris <xyz.biris@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4d6522b90501160206306b0140@mail.gmail.com>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
	 <1105461106.16168.41.camel@localhost.localdomain>
	 <4e1a70d1050111111614670f32@mail.gmail.com>
	 <4e1a70d10501111246391176b@mail.gmail.com>
	 <1105630523.4644.52.camel@localhost.localdomain>
	 <4d6522b90501160206306b0140@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105907681.12201.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 16 Jan 2005 21:10:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-16 at 10:06, Edjard Souza Mota wrote:
> What do you think about the point we are trying to make, i.e., moving the
> ranking of PIDs to be killed to user space? Or, making user have some influence
> on it? We were misunderstood because the patch we sent was to make "a slight"
> organization in the way OOM killer compute rates to PIDs, not to change its

Im sceptical there is an answer but moving it to user space (or at least
implementing /proc tunables in user space to experiment) certainly seems
to be the right way to find out.

> Well, while AF_TELEPATH socket is not on its way :) ... we may at
> least experiment
> different raking policies.

agreed

