Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbWKEJlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbWKEJlW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 04:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWKEJlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 04:41:22 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:972 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932604AbWKEJlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 04:41:21 -0500
Message-ID: <454DB1BE.7030103@garzik.org>
Date: Sun, 05 Nov 2006 04:41:18 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: otto Meier <gf435@gmx.net>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: More Promise chipset specs opened
References: <454C6767.3090901@gmx.net> <454C92D2.8060809@garzik.org> <454DA7A9.7000608@gmx.net>
In-Reply-To: <454DA7A9.7000608@gmx.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

otto Meier wrote:
> Jeff Garzik schrieb:
>> otto Meier wrote:
>>> In which controller classes does it belong?
>>> Promise claims it should  have NCQ  how to enable ?
>> If it claims NCQ and 3.0Gbps support, I would guess 205xx
>>
>>     Jeff
>>
> Does this mean, changing :
> 
>  { PCI_VDEVICE(PROMISE, 0x3d17), board_20319 },
> to
>  { PCI_VDEVICE(PROMISE, 0x3d17), board_2057X },
> 
> in sata_promise.c would do the trick to activate NCQ of this board?
> 
> Does this hurt?
> Do I need to do something else to get NCQ working?

Heh, no, a lot more than that...  NCQ is not supported at all in the 
driver.  If someone is looking for a project, the docs are now available 
for them to work on NCQ.

	Jeff



