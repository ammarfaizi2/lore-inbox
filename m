Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266132AbRF2R7G>; Fri, 29 Jun 2001 13:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbRF2R65>; Fri, 29 Jun 2001 13:58:57 -0400
Received: from [194.213.32.142] ([194.213.32.142]:7940 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266139AbRF2R6X>;
	Fri, 29 Jun 2001 13:58:23 -0400
Message-ID: <20010629005200.G525@bug.ucw.cz>
Date: Fri, 29 Jun 2001 00:52:00 +0200
From: Pavel Machek <pavel@suse.cz>
To: Balbir Singh <balbir_soni@yahoo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <E15D2GI-00019a-00@the-village.bc.nu> <20010621124337.44506.qmail@web13605.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010621124337.44506.qmail@web13605.mail.yahoo.com>; from Balbir Singh on Thu, Jun 21, 2001 at 05:43:37AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The problem is that the IRQ has to be cleared in
> > kernel space, because otherwise
> > you may deadlock. 
> > 
> 
> I agree, the idea is to clear the IRQ in kernel space
> and then deliver to user level programs interested

...*IF* you know how to clear it. THat differs device-to-device.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
