Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267603AbUHEIwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267603AbUHEIwk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 04:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267606AbUHEIwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 04:52:40 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:30988 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267603AbUHEIwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 04:52:38 -0400
Message-ID: <4111F624.7080605@hist.no>
Date: Thu, 05 Aug 2004 10:56:04 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@yahoo.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: OLS and console rearchitecture
References: <20040802142416.37019.qmail@web14923.mail.yahoo.com>
In-Reply-To: <20040802142416.37019.qmail@web14923.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:

>
>2) VGA control - there needs to be a device for coordinating this. It
>would ensure that only a single VGA device gets enabled at a time. It
>would also adjust PCI bus routing as needed. It needs commands for
>disabling all VGA devices and then enabling a selected one. This device
>may need to coordinate with VGA console. You have to use this device
>even if you aren't using VGA console since it ensures that only a
>single VGA device gets enabled.
>Alan Cox: what about hardware that supports multiple vga routers? do we
>care?
>  
>
Isn't the "unique VGA" a disappearing problem?
I have the impression that many new (PCI/AGP) video cards
can work fine without the legacy VGA stuff - therefore, no conflict
when using several cards simultaneously.

Please avoid unnecessary disabling of such devices, that only causes
trouble for those of use trying to use several screens at once. (Possibly
with several simultaneous _users_, who don't want their screen disabled 
for no
good reason.) Of course one may have to buy the "right" cards when 
setting up
such a machine.

Helge Hafting
