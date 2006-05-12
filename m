Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWELXKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWELXKs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWELXKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:10:48 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:11969 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751188AbWELXKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:10:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BKgl1vHyr+l/r2784xlGUP4L2tND7wED6gaEmolUbn9rSRo0KEyUFz8khaJrxE3RSPTZMhq2BcPGz4G0U51Y7zYPPkzQNF7OuKdtmLBOWrabUKW4D5o989zza6CDLN61xA4P4yRHiUIUYetW5q77ohIjpUZ0+Udq8slJcZmZ/YA=
Message-ID: <446515F0.7070702@gmail.com>
Date: Sat, 13 May 2006 08:10:40 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
References: <200605121534.k4CFYodu020885@harpo.it.uu.se>
In-Reply-To: <200605121534.k4CFYodu020885@harpo.it.uu.se>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> On Fri, 12 May 2006 22:24:37 +0900, Tejun Heo wrote:
>> The following drivers support new features.
>>
>> ata_piix:	new EH, irq-pio, warmplug (hardware restriction)
>> sata_sil:	new EH, irq-pio, hotplug
>> ahci:		new EH, irq-pio, NCQ, hotplug
>> sata_sil24:	new EH, irq-pio, NCQ, hotplug, Port Multiplier
> 
> If you were to add new EH and NCQ support to sata_promise,
> then I'd test it on my News server.
> 

I have a promise card and played with it a little bit but I don't have
access to hardware doc.  So...

-- 
tejun
