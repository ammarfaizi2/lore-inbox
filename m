Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbWHDPdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbWHDPdR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 11:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWHDPdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 11:33:17 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:60369 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S932595AbWHDPdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 11:33:16 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.3
Subject: Re: Problem: irq 217: nobody cared + backtrace
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net,
       Greg Kroah-Hartman <gregkh@suse.de>
In-Reply-To: <Pine.LNX.4.44L0.0608031158560.7384-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0608031158560.7384-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=utf-8
Date: Fri, 04 Aug 2006 16:33:11 +0100
Message-Id: <1154705591.5588.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 12:08 -0400, Alan Stern wrote:
> Has this happened more than once?  

In my case (it very different), all the time.
I also got :
uhci_hcd 0000:00:10.1: host controller process error, something bad
happened!
uhci_hcd 0000:00:10.1: host controller halted, very bad!
uhci_hcd 0000:00:10.1: HC died; cleaning up
usb 3-2: USB disconnect, address 2

> In case it happens again, here's how 
> you can get more information.  Turn on CONFIG_USB_DEBUG and 
> CONFIG_DEBUG_FS, and mount a debugfs filesystem somewhere (say 
> /sys/kernel/debug).  Then after the problem occurs, save a copy of 
> 
>         /sys/kernel/debug/uhci/0000:00:1d.1 

can you explain to me how I mount debugfs filesystem ? please

Thanks,
--
Sérgio M. B.

