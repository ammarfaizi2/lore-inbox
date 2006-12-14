Return-Path: <linux-kernel-owner+w=401wt.eu-S932896AbWLNUnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932896AbWLNUnz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932900AbWLNUnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:43:55 -0500
Received: from www.osadl.org ([213.239.205.134]:44722 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932896AbWLNUnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:43:55 -0500
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612140924140.5718@woody.osdl.org>
References: <20061213195226.GA6736@kroah.com>
	 <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	 <1166044471.11914.195.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0612132219480.32433@yvahk01.tjqt.qr>
	 <Pine.LNX.4.64.0612131522310.5718@woody.osdl.org>
	 <Pine.LNX.4.61.0612141206500.6223@yvahk01.tjqt.qr>
	 <Pine.LNX.4.64.0612140924140.5718@woody.osdl.org>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 21:47:42 +0100
Message-Id: <1166129262.29505.120.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 09:26 -0800, Linus Torvalds wrote:
> 
> On Thu, 14 Dec 2006, Jan Engelhardt wrote:
> > 
> > I don't get you. The rtc module does something similar (RTC generates
> > interrupts and notifies userspace about it)
> 
> The RTC module knows how to shut the interrupt up.

The kernel part of the UIO driver also knows how to shut the interrupt
up, so where is the difference ?

	tglx



