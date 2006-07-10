Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965234AbWGJVRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbWGJVRh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 17:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbWGJVRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 17:17:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:41394 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965234AbWGJVRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 17:17:36 -0400
Subject: Re: Linux v2.6.18-rc1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: will_schmidt@vnet.ibm.com, Steve Fox <drfickle@us.ibm.com>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1152542413.27368.131.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	 <pan.2006.07.07.15.41.35.528827@us.ibm.com>
	 <1152441242.4128.33.camel@localhost.localdomain>
	 <1152537672.28828.4.camel@farscape.rchland.ibm.com>
	 <1152542413.27368.131.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 07:17:16 +1000
Message-Id: <1152566236.1576.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That in repeat generally means the IRQ logic on the platform has been
> broken. If we don't get interrupts we don't work very well.
> 
> Also check if booting with "nodma" set on the relevant ide interface
> makes a difference. Just to be sure. If it does then submit patches to
> fix the bug.

it's most certainly an irq problem as I just rewrote the irq logic of
powerpc :) There have been some issues and I've just sent some new
patches fixing them, let's see if that's enough. I'll give a js20 a try
today at work.

Ben.

