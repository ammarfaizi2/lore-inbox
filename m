Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWEMEMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWEMEMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 00:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWEMEMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 00:12:16 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:23266 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932321AbWEMEMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 00:12:14 -0400
Message-ID: <44655C99.5050609@garzik.org>
Date: Sat, 13 May 2006 00:12:09 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
References: <200605121534.k4CFYodu020885@harpo.it.uu.se> <446515F0.7070702@gmail.com>
In-Reply-To: <446515F0.7070702@gmail.com>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Mikael Pettersson wrote:
>> On Fri, 12 May 2006 22:24:37 +0900, Tejun Heo wrote:
>>> The following drivers support new features.
>>>
>>> ata_piix:	new EH, irq-pio, warmplug (hardware restriction)
>>> sata_sil:	new EH, irq-pio, hotplug
>>> ahci:		new EH, irq-pio, NCQ, hotplug
>>> sata_sil24:	new EH, irq-pio, NCQ, hotplug, Port Multiplier
>> If you were to add new EH and NCQ support to sata_promise,
>> then I'd test it on my News server.
>>
> 
> I have a promise card and played with it a little bit but I don't have
> access to hardware doc.  So...

I have Promise NCQ info, just waiting for the chance to use it :)

Plus I have a nagging suspicion that the SATA II cards have a few
differences from the SATA I cards that have yet to be coded into
sata_promise.c.

	Jeff



