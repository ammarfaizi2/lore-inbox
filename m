Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVCCUij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVCCUij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVCCUe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:34:59 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:58026
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262453AbVCCUeP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:34:15 -0500
Subject: Re: RFD: Kernel release numbering
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <42276AF5.3080603@pobox.com>
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
	 <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>
	 <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
	 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
	 <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <20050303170808.GG4608@stusta.de>
	 <1109877336.4032.47.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.58.0503031135190.25732@ppc970.osdl.org>
	 <42276AF5.3080603@pobox.com>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 21:34:03 +0100
Message-Id: <1109882043.4032.79.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 14:52 -0500, Jeff Garzik wrote:
> I disagree it's unsolvable:
> 
> 1) At some point in the -rc cycle, you put your foot down and say 
> "nothing but bugfixes."

Release candidates are supposed to be bugfix only from -rc1. Everything
else can only be called the "ridiculous count".

> That's all the 2.4.x's -pre/-rc accomplishes.  It encourages people to 
> test, by telling them when their testing would be most useful.

Correct, but again 2.4 is a different beast as no active development is
taking place.

In a active development you should move the -rc step out of the
development line into a seperate release line after the -preX steps. 

It has two advantages:

1. The release process is encapsulated and secure against non bugfix
merges. This can be "sold" to users for testing.

2. The development cycle is more continous. While -rc1 is led to release
2.6.X the preparations for 2.6.X+1-pre1 are moving on. This might
shorten the overall release cycles as well.

tglx



