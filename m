Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTLUChf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 21:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTLUChf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 21:37:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42626 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262078AbTLUChd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 21:37:33 -0500
Message-ID: <3FE5075D.9080704@pobox.com>
Date: Sat, 20 Dec 2003 21:37:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-net@vger.kernel.org, dbrownell@users.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let USB_{PEGASUS,USBNET} depend on NET_ETHERNET
References: <20031221022242.GT12750@fs.tum.de>
In-Reply-To: <20031221022242.GT12750@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> I observed the following small problem in 2.6:
> 
> - MII depends on NET_ETHERNET
> - USB_PEGASUS and USB_USBNET select MII, but they depend only on NET
>  
> The patch below lets USB_PEGASUS and USB_USBNET depend on NET_ETHERNET 
> instead of NET to fix this issue.


Look OK to me.  I'll let GregKH apply...

