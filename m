Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbVKWPUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbVKWPUM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbVKWPUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:20:12 -0500
Received: from [85.8.13.51] ([85.8.13.51]:15520 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750986AbVKWPUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:20:10 -0500
Message-ID: <438488A0.8050104@drzeus.cx>
Date: Wed, 23 Nov 2005 16:20:00 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Christmas list for the kernel
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <20051122204918.GA5299@kroah.com> <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com> <20051123121726.GA7328@ucw.cz> <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com> <20051123150349.GA15449@flint.arm.linux.org.uk>
In-Reply-To: <20051123150349.GA15449@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Nov 23, 2005 at 09:43:58AM -0500, Jon Smirl wrote:
>> My system has:
>> 2 serial
>>
>> In /sys/bus/platform/devices I see this:
>> serial8250
>> shouldn't there be entries for all of the legacy devices?
>>
>> In /dev
>> ttyS0
>> ttyS1
>> ttyS2
>> ttyS3
> 
> You're basically confused about serial ports.  The kernel serial devices
> whether or not hardware is found, to allow programs such as setserial to
> function.
> 
> If you disagree with that, there'll be an equal number of people who
> have serial cards that need setserial who will in turn disagree with
> you.
> 

But if no hardware is connected to those devices, then where does the 
driver route the setserial stuff?

We had a similar discussion regarding hal and the final solution was to 
check the uart type to determine if the port was there or not.

Rgds
Pierre

