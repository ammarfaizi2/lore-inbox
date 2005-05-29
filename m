Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVE2S12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVE2S12 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 14:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVE2S11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 14:27:27 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:7035 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261387AbVE2S1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 14:27:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=SDPVVk77R/o68uW91Hj6Ww3tTrENQaWGT0UrV/qmNw21D4uGtzi9VV4EmMT98BGQFGfuwTymekF8r904FtDeRLbXmdJI2re/ocDbAto6kOht1HktzF+yBhqlo3NNgJ3ZTua2z+bpFnn2dKaAR4YUq1qVO82Vtt0tw2uPRlmGeT8=
Message-ID: <429A0977.5040601@gmail.com>
Date: Sun, 29 May 2005 20:27:03 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050523)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Erik Slagter <erik@slagter.name>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de>	 <1117382598.4851.3.camel@localhost.localdomain>	 <4299EF16.2050208@pobox.com>	 <1117385429.4851.8.camel@localhost.localdomain>	 <4299F4E2.4020305@pobox.com>	 <1117387432.4851.13.camel@localhost.localdomain>	 <20050529172949.GA3578@havoc.gtf.org> <1117388703.4851.21.camel@localhost.localdomain> <429A036D.8090104@pobox.com>
In-Reply-To: <429A036D.8090104@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik schrieb:

> Erik Slagter wrote:
>
>> I guess the only way to have, for example the ICH6, not using legacy
>> IRQ/ports, is to switch it to AHCI, which only the BIOS can do (if
>> implemented).
>
>
> "native mode" is where PATA and/or SATA PCI device is programmed into
> full PCI mode -- PCI BARs, PCI irq, etc.  Some BIOSen allow you to
> enable mode, which disables all use of legacy IRQ/ports.
>
> Also, ICH6 silicon does not support AHCI, only ICH6-R and ICH6-M.
>
>     Jeff
>
Hello Jeff,

AHCI also works when the so called option "RAID mode" on ICH6R/ICH7 is set.

One question in addition when will the patch of Jens in libata-2.6
tree?or is it already merged?


/Michael
