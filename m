Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbVIRAPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVIRAPe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 20:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVIRAPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 20:15:34 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:62414 "HELO
	develer.com") by vger.kernel.org with SMTP id S1751244AbVIRAPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 20:15:34 -0400
Message-ID: <432CB177.5070001@develer.com>
Date: Sun, 18 Sep 2005 02:14:47 +0200
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matheus Izvekov <izvekov@lps.ele.puc-rio.br>
CC: Development discussions related to Fedora Core 
	<fedora-devel-list@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
Subject: Re: Assertion failed in libata-core.c:ata_qc_complete(3051)
References: <432BA524.40301@develer.com> <60030.200.141.101.221.1126969752.squirrel@correio.lps.ele.puc-rio.br>
In-Reply-To: <60030.200.141.101.221.1126969752.squirrel@correio.lps.ele.puc-rio.br>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=FC6A66CA;
	url=https://www.develer.com/~bernie/gpgkey.txt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matheus Izvekov wrote:

>>I have a Promise TX4 controller with 4 SATA drivers
>>formatted with a RAID1 and a RAID5 md.  LVM on top of this.
> 
> Can you reproduce this with a stock kernel?

I've just opened the case to install some more RAM and
noticed that the SATA controller card wasn't completely
fitted into the PCI slot.  Could it be just a hardware
problem?  I don't know what that assartion is about.

Nowadays, Fedora kernels don't differ much from stock
kernels plus the usual bugfixes.  I've now upgraded to
2.6.13-1.1555-FC5 because it fixes an iptables bug.
I'll report if I see this bug again.


> Also, i think it would be
> better if instead of sending a screenshot, get a serial cable and boot
> with console=ttyS*

This is happening on our production server, and there are no
other computers next to it, so I can't easily hook in a
serial cable.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

