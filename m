Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTIOUdw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbTIOUdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:33:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:46504 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261575AbTIOUdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:33:51 -0400
Date: Mon, 15 Sep 2003 13:30:40 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5-mm2: oops when trying to suspend
In-Reply-To: <1063652209.1330.4.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.33.0309151329530.950-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I get the following oops when trying to suspend my computer.
> 
> Stopping tasks: =====|
> Unable to handle kernel paging request at virtual address fffffff4

> EIP is at usb_device_suspend+0x24/0x50 [usbcore]

This is a known problem. Please either remove the usb drivers before 
suspending, or apply the patch here: 

http://marc.theaimsgroup.com/?l=linux-kernel&m=106315363102204&w=2

Thanks,


	Pat


