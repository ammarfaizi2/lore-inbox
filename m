Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268383AbUILA1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268383AbUILA1M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 20:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268381AbUILA1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 20:27:11 -0400
Received: from the-village.bc.nu ([81.2.110.252]:65203 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268383AbUILA0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 20:26:11 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339104091114374b9545f5@mail.gmail.com>
References: <9e47339104091010221f03ec06@mail.gmail.com>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <20040911132727.A1783@infradead.org>
	 <9e47339104091109111c46db54@mail.gmail.com>
	 <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
	 <9e473391040911105448c3f089@mail.gmail.com>
	 <Pine.LNX.4.58.0409111058320.2341@ppc970.osdl.org>
	 <9e4733910409111402138737aa@mail.gmail.com>
	 <20040911220614.A5023@infradead.org>
	 <9e47339104091114374b9545f5@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094945033.21692.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 12 Sep 2004 00:23:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-11 at 22:37, Jon Smirl wrote:
> But since I've written most of the code so far I get to pick the
> details of the implementation. 

Umm thats what happened to ruby and thats what happened to KGI.

> If Alan would instead like to pick the
> details I've offered to withdraw if he'll write the code needed to
> implement the major points of the plan.

I'll try and debug the vga generic (Linus "stupid" driver as he calls
it). That'll provide the framework to plug the other bits in. That needs
doing anyway to get hotplugging and all the other sane stuff right (oh
and probably sysfs but someone else can do that).

I was using much simpler lock ideas than Linus but I'll have a poke at
that too, something more like a dri lock that knows who had it last.

Alan

