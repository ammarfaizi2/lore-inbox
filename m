Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266137AbRF2R5p>; Fri, 29 Jun 2001 13:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbRF2R5f>; Fri, 29 Jun 2001 13:57:35 -0400
Received: from [194.213.32.142] ([194.213.32.142]:6404 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266132AbRF2R5X>;
	Fri, 29 Jun 2001 13:57:23 -0400
Message-ID: <20010629005116.F525@bug.ucw.cz>
Date: Fri, 29 Jun 2001 00:51:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <20010621104132.91801.qmail@web13609.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010621104132.91801.qmail@web13609.mail.yahoo.com>; from Balbir Singh on Thu, Jun 21, 2001 at 03:41:32AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I realize that the Linux kernel supports user
> level drivers (via ioperm, etc). However interrupts
> at user level are not supported, does anyone think
> it would be a good idea to add user level interrupt
> support ? I have a framework for it, but it still
> needs
> a lot of work.
> 
> Depending on the response I get, I can send out
> more email. Please cc me to the replies as I am no
> longer a part of the Linux kernel mailing list - due
> to the humble size of my mail box.

I'd like to see that done for userspace ltmodem
driver... Unfortunately it can not be easily done for shared PCI
interrupts.
								Pavel
PS: Next needed thing is to make it possible for usermode driver to
"mimic" kernel one, including ioctls.
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
