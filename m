Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268207AbUJOQzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268207AbUJOQzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268199AbUJOQzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:55:22 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:56905 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268197AbUJOQzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:55:09 -0400
Subject: Re: 2.6.9-rc4-mm1 : oops when rmmod uhci_hcd  [was: 2.6.9-rc3-mm2
	: oops...]
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.44L0.0410151215440.1052-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0410151215440.1052-100000@ida.rowland.org>
Content-Type: text/plain
Message-Id: <1097858939.2820.3.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 15 Oct 2004 11:48:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 11:18, Alan Stern wrote:
> Your explanation sounds entirely reasonable to me.  Can you pass it on to 
> the people responsible for the generic-irq subsystem?

I CCd Ingo Molnar, who appears to be the originator
of these patches.

There was a question in my mind about the hcd->description field.
Should it be unique for each device instance instead
of uniform for all device instances on a driver?

-- 
Paul Fulghum
paulkf@microgate.com

