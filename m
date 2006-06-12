Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWFLUUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWFLUUj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 16:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWFLUUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 16:20:39 -0400
Received: from rtr.ca ([64.26.128.89]:26003 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932232AbWFLUUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 16:20:38 -0400
Message-ID: <448DCC94.7080800@rtr.ca>
Date: Mon, 12 Jun 2006 16:20:36 -0400
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
> 
> Unplugging the hub/dock does this:
> 
> kernel BUG at kernel/workqueue.c:110!
> invalid opcode: 0000 [#1]
> PREEMPT
>...

MMmm.. entire USB subsystem is toast after that -- reboot required.

Cheers
