Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbTIIQAY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 12:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbTIIQAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 12:00:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:13005 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264196AbTIIQAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 12:00:22 -0400
Date: Tue, 9 Sep 2003 08:57:42 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Driver model problems in -test5: usb this time
In-Reply-To: <20030909122938.GA12450@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0309090854220.919-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Upon attempt to swsusp, I get "Unable to handle kernel paging request
> at virtual address fffffff4" in usb_device_suspend, called from
> suspend_device, device_suspend, drivers_suspend, do_software_suspend,
> ....

Unfortunately, we don't have a 'taint' flag for when extra patches are 
added to an official release. 

The latter two functions do not exist in -test5. It would helpful if you 
tried to reproduce with a virgin -test5. It would be courteous to state 
what patches you applied on top of the virgin -test5 kernel. 

The entire Oops would also help, captured either by hand or with e.g. a 
digital camera. You may want to cc the usb-devel list, too.

Thanks,


	Pat

