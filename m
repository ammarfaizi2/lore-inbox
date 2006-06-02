Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWFBO5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWFBO5d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 10:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWFBO5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 10:57:33 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:6923 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1750774AbWFBO5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 10:57:32 -0400
Message-ID: <448051D6.808@rainbow-software.org>
Date: Fri, 02 Jun 2006 16:57:26 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Mark Lord <lkml@rtr.ca>, Grant Coady <gcoady.lk@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Query: No IDE DMA for IBM 365X with PIIX chipset?
References: <j9bi729h2u4dcn9da7na3t1d8ckk477d9b@4ax.com>	 <1149169812.12932.20.camel@localhost>  <447F2257.4000404@rtr.ca> <1149187933.12932.70.camel@localhost>
In-Reply-To: <1149187933.12932.70.camel@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2006-06-01 at 13:22 -0400, Mark Lord wrote:
>> That's the original Intel "triton" chipset.
>> I have a spare printed Intel document for the chipset (Intel #290519-001)
>> which I can mail you (Alan).  Email me privately with a postal address.
> 
>>From the other docs it appears 0x122E is the ISA bridge and this laptop
> has 0x122E (PIIX bridge) and an 82437MX system controller, but no PIIX
> IDE. That actually suggests its more like the "MPIIX" which has a PIO
> only IDE controller existing (logically anyway) on the ISA side of the
> system.
> 
> That would explain the observed behaviour and fit with the pattern of
> PCI identifiers. Now to hunt 82437 docs.
> 
> (In the mean time try adding the 0x1235 id to the 2.6.17-mm kernel in
> drivers/scsi/pata_mpiix and see if that works with the new libata layer
> not drivers/ide).

Maybe http://stuff.mit.edu/afs/sipb/contrib/doc/specs/unfiled/i82437MX.pdf

-- 
Ondrej Zary
