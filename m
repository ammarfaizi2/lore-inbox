Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269242AbTGOSRn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269285AbTGOSQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:16:57 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:50402 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S269242AbTGOSPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:15:09 -0400
Message-ID: <3F14491B.6020809@pacbell.net>
Date: Tue, 15 Jul 2003 11:34:03 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
CC: Ruben Puettmann <ruben@puettmann.net>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: Problems with usb-ohci on 2.4.22-preX
References: <20030712141431.GA3240@puettmann.net> <200307151547.22615.roger.larsson@skelleftea.mail.telia.com>
In-Reply-To: <200307151547.22615.roger.larsson@skelleftea.mail.telia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Larsson wrote:
> I am not alone then...
> 
>>hub.c: new USB device 00:02.1-3, assigned address 2
>>usb_control/bulk_msg: timeout
>>usb-ohci.c: unlink URB timeout
>>usb.c: USB device not accepting new address=2 (error=-110)
> 
> 
> This is exactly what I get (2.4.20). But I use quite different hardware.
> STPC Atlas (100MHz, for an embedded project)

Q:  Why doesn't USB work at all? I get "device not accepting address".

   http://www.linux-usb.org/FAQ.html#ts6

Basically, if your PCI IRQ routing is broken, USB won't work.  Likely
that FAQ entry could stand updating (ACPI vs APCI etc).  There are
still significant issues there in 2.6 kernels; and I've hardly ever
seen ACPI do anything except break USB.

- Dave


