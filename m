Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262526AbRFBMFT>; Sat, 2 Jun 2001 08:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262530AbRFBMFJ>; Sat, 2 Jun 2001 08:05:09 -0400
Received: from mailrelay.bluelabs.se ([194.17.38.34]:17676 "HELO
	mailrelay.bluelabs.se") by vger.kernel.org with SMTP
	id <S262526AbRFBME4>; Sat, 2 Jun 2001 08:04:56 -0400
To: Andre Hedrick <andre@aslab.com>
Cc: magnus.sandberg@test.bluelabs.se, linux-kernel@vger.kernel.org,
        linux-smp@vger.kernel.org
From: Magnus.Sandberg@bluelabs.se
Subject: Re: Problem with kernel 2.2.19 Ultra-DMA and SMP, once more
MIME-Version: 1.0
Date: Sat, 2 Jun 2001 14:04:48 +0200
Message-ID: <OF9113DCEA.9630D3AB-ONC1256A5F.00425B56@bluelabs.se>
X-MIMETrack: Serialize by Router on Blue-sth3/srv/Bluelabs(Release 5.0.6a |January 17, 2001) at
 2001-06-02 14:04:48
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andre,

The motherboard has VIA-chipset.

What does this mean for me?

Will the APIC-problems be solved in the future or do I have to deside upon
running "noapic" semi-crippled or not run Ultra-DMA?


                                  _\\|//_
                                  (-0-0-)
/-------------------------------ooO-(_)-Ooo------------------------------\
| Magnus Sandberg                    Email: Magnus.Sandberg@bluelabs.se  |
| Network Engineer, Bluelabs                     http://www.bluelabs.se/ |
| Phone: +46-8-470 2155    (FAX: +46-8-470 2199)    GSM: +46-708-225 805 |
\------------------------------------------------------------------------/
                                  ||   ||
                                 ooO   Ooo


 ----- On 1st of June 2001 Andre Hedrick wrote; -----

If this is a VIA SMP system there are APIC problems that you do not want
to even think about addressing.

MPS1.1 and passing "noapic" will fix most of there mess, but you have a
semi-crippled system, but it runs.

On Fri, 1 Jun 2001 Magnus.Sandberg@bluelabs.se wrote:

> Hi once more...
>
> I'm sorry for the layout of this mail. It is written in a web mail
> system...
> The attachements are in ASCII format even if the web-mail make it base-64
>
> Now I have compiled a vanilla 2.2.19 kernel and have SMP working, without
> Ultra-DMA. I used the functional kernel config from 2.2.19-ide and just
> activated SMP.
>
> >From that I have 3 very simular kernel configurations:
> 2.2.19 with Hidrick's IDE-patch, no SMP: working
> 2.2.19 without IDE-patch, with SMP: working
> 2.2.19 with IDE-patch and SMP: not booting
>
> With all the information I hope that someone can help me with the
> IDE-and-SMP problem.

