Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312901AbSDSPLJ>; Fri, 19 Apr 2002 11:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312931AbSDSPLI>; Fri, 19 Apr 2002 11:11:08 -0400
Received: from NS.iNES.RO ([193.230.220.1]:6637 "EHLO Master.iNES.RO")
	by vger.kernel.org with ESMTP id <S312901AbSDSPLH>;
	Fri, 19 Apr 2002 11:11:07 -0400
Subject: Re: [PATCH] Wrong IRQ for USB on Sony Vaio (dmi_scan.c, pci-irq.c)
From: Dumitru Ciobarcianu <cioby@lnx.ro>
To: Dave Jones <davej@suse.de>
Cc: Jan Slupski <jslupski@email.com>, linux-kernel@vger.kernel.org,
        alan@redhat.com
In-Reply-To: <20020419165615.A23782@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-3) 
Date: 19 Apr 2002 18:10:09 +0300
Message-Id: <1019229009.1928.24.camel@LNX.iNES.RO>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Vi, 2002-04-19 at 17:56, Dave Jones wrote:
> On Fri, Apr 19, 2002 at 04:43:15PM +0200, Jan Slupski wrote:
> 
>  > Do you know any simple tool to retrieve DMI information?
> 
> http://people.redhat.com/arjanv/dmidecode.c
> 



On my machine (Toshiba Satellite Pro 4300 series) running dmidecode
gives me this....


[root@LNX root]# ./dmidecode  
RSD PTR found at 0xF0170
checksum failed.
OEM TOSHIB
SMBIOS 2.3 present.
DMI 2.3 present.
46 structures occupying 1369 bytes.
DMI table at 0x0FFF0000.
dmi: read: Success
read: Illegal seek
DMI 2.3 present.
46 structures occupying 1369 bytes.
DMI table at 0x0FFF0000.
dmi: read: Illegal seek
read: Illegal seek
...

And keeps repeating...

Any hint why?

//Cioby


