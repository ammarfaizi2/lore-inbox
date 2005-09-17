Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVIQPKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVIQPKE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 11:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVIQPKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 11:10:04 -0400
Received: from juno.lps.ele.puc-rio.br ([139.82.40.34]:51626 "EHLO
	juno.lps.ele.puc-rio.br") by vger.kernel.org with ESMTP
	id S1751098AbVIQPKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 11:10:03 -0400
Message-ID: <60030.200.141.101.221.1126969752.squirrel@correio.lps.ele.puc-rio.br>
In-Reply-To: <432BA524.40301@develer.com>
References: <432BA524.40301@develer.com>
Date: Sat, 17 Sep 2005 12:09:12 -0300 (BRT)
Subject: Re: Assertion failed in libata-core.c:ata_qc_complete(3051)
From: "Matheus Izvekov" <izvekov@lps.ele.puc-rio.br>
To: "Bernardo Innocenti" <bernie@develer.com>
Cc: "Development discussions related to Fedora Core" 
	<fedora-devel-list@redhat.com>,
       "lkml" <linux-kernel@vger.kernel.org>, "Dave Jones" <davej@redhat.com>
User-Agent: SquirrelMail/1.4.3a-6.FC2
X-Mailer: SquirrelMail/1.4.3a-6.FC2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sab, Setembro 17, 2005 2:09 am, Bernardo Innocenti disse:
> Sorry for attaching a screenshot, I couldn't find a better
> way to grab the panic message :-)
>
> I get this panic occasionally (every 1-2 days) since I
> upgraded to kernel-2.6.12-1.1447_FC4.
> I've gone back to 2.6.12-1.1369_FC4 and the machine has
> not yet crashed after 3 days.
>
> I have a Promise TX4 controller with 4 SATA drivers
> formatted with a RAID1 and a RAID5 md.  LVM on top of this.
>

Can you reproduce this with a stock kernel? Also, i think it would be
better if instead of sending a screenshot, get a serial cable and boot
with console=ttyS*
