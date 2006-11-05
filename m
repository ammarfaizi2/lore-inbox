Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbWKEKMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbWKEKMd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 05:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWKEKMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 05:12:32 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:27332 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932619AbWKEKMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 05:12:31 -0500
Message-ID: <454DB8D1.3010708@gmx.net>
Date: Sun, 05 Nov 2006 11:11:29 +0100
From: otto Meier <gf435@gmx.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: More Promise chipset specs opened
References: <454C6767.3090901@gmx.net> <454C92D2.8060809@garzik.org> <454DA7A9.7000608@gmx.net> <454DB1BE.7030103@garzik.org>
In-Reply-To: <454DB1BE.7030103@garzik.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:468b128da021a7447d21877842847db4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik schrieb:
> otto Meier wrote:
>> Jeff Garzik schrieb:
>>> otto Meier wrote:
>>>> In which controller classes does it belong?
>>>> Promise claims it should  have NCQ  how to enable ?
>>> If it claims NCQ and 3.0Gbps support, I would guess 205xx
>>>
>>>     Jeff
>>>
>> Does this mean, changing :
>>
>>  { PCI_VDEVICE(PROMISE, 0x3d17), board_20319 },
>> to
>>  { PCI_VDEVICE(PROMISE, 0x3d17), board_2057X },
>>
>> in sata_promise.c would do the trick to activate NCQ of this board?
>>
>> Does this hurt?
>> Do I need to do something else to get NCQ working?
>
> Heh, no, a lot more than that...  NCQ is not supported at all in the
> driver.  If someone is looking for a project, the docs are now
> available for them to work on NCQ.
>
I would take it but I am not able to do the programming, but I would
volunteer in testing.

Otto

