Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbWHIDpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbWHIDpd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 23:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWHIDpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 23:45:32 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:12955 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030447AbWHIDpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 23:45:32 -0400
Message-ID: <44D95A58.6070706@garzik.org>
Date: Tue, 08 Aug 2006 23:45:28 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Arjan Van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Nicolas Pitre <nico@cam.org>
Subject: Re: lockdep: fix smc91x
References: <20060727144420.GB5178@flint.arm.linux.org.uk>
In-Reply-To: <20060727144420.GB5178@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Hi,
> 
> When booting using root-nfs, I'm seeing (independently) two lockdep dumps
> in the smc91x driver.  The patch below fixes both.  Both dumps look like
> real locking issues.
> 
> Nico - please review and ack if you think the patch is correct.

Was this ever ACK'd?

I would prefer spin_lock_irqsave(), but that's just a quibble.  I would 
be OK with applying this.

	Jeff


