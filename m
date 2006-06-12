Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWFLUlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWFLUlR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWFLUlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:41:17 -0400
Received: from rtr.ca ([64.26.128.89]:20608 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751015AbWFLUlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:41:16 -0400
Message-ID: <448DD16A.9090609@rtr.ca>
Date: Mon, 12 Jun 2006 16:41:14 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb,
 error -28
References: <448DC93E.9050200@rtr.ca>
In-Reply-To: <448DC93E.9050200@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Greg,
> 
> With 2.6.17-rc6-git2, I'm seeing this kernel message during start-up:
> 
>  pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb, error -28
> 
> The pl2303 serial port is part of a USB1.1 Hub/dock device,
> plugged into a USB2 port on my notebook.
> 
> I get the same failure again when trying to use the port with Kermit.
> This device was working fine here not long ago -- on the -rc5 kernels I 
> think.

Mmm.. no, it's broken in 2.6.17-rc5 as well.
I'll go back to 2.6.16.xx now, and see about that.

> 
> Unplugging the hub/dock does this:
> 
> kernel BUG at kernel/workqueue.c:110!
> invalid opcode: 0000 [#1]
> PREEMPT
...
