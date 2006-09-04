Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWIDWbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWIDWbA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWIDWbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:31:00 -0400
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:7146 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S932149AbWIDWa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:30:59 -0400
Message-ID: <44FCA920.4020706@bellsouth.net>
Date: Mon, 04 Sep 2006 17:30:56 -0500
From: Jay Cliburn <jacliburn@bellsouth.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc5-mm1 unusual IRQ number for VIA device
References: <fa.zOFUKsGFxa+fu0uGVN6HuRT+Krg@ifi.uio.no> <fa.2CAUcMm0GNX2+CNwugoJEUNtwzQ@ifi.uio.no> <44FCA4EC.3060507@shaw.ca>
In-Reply-To: <44FCA4EC.3060507@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Jay Cliburn wrote:
>> Jay Cliburn wrote:
>>> Running 2.6.18-rc5.mm1 on an Asus M2V mainboard with dual-core Athlon 
>>> cpu, the onboard audio device gets assigned and IRQ of 8410.  Under 
>>> 2.6.18-rc4-mm3, the same device gets assigned IRQ 17.  Is this a way 
>>> to get around this?
>>
>> What I meant to ask is:  Is there a way to get around this?
>>
>> Thanks,
>> Jay
> 
> What do you think needs to be "gotten around"? It is using MSI 
> interrupts, I think that the IRQ numbers will be different.
> 

I'll have to go research what MSI interrupts are.  Thanks for the pointer.

Unfortunately, Fedora Core's irqbalance segfaults when it encounters the 
IRQ of 8410.  I assumed this behavior indicated that an IRQ number 
shouldn't be that large.

Thanks again.
