Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314265AbSDVQNY>; Mon, 22 Apr 2002 12:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314266AbSDVQNX>; Mon, 22 Apr 2002 12:13:23 -0400
Received: from w226.z064000207.nyc-ny.dsl.cnc.net ([64.0.207.226]:6704 "EHLO
	carey-server.stronghold.to") by vger.kernel.org with ESMTP
	id <S314265AbSDVQNV>; Mon, 22 Apr 2002 12:13:21 -0400
Message-Id: <4.3.2.7.2.20020422120453.01c43538@mail.strongholdtech.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 22 Apr 2002 12:15:24 -0400
To: "Vasja J Zupan" <vasja@nuedi.com>, <linux-kernel@vger.kernel.org>
From: "Nicolae P. Costescu" <nick@strongholdtech.com>
Subject: Re: HPT372 on KR7A-133R (ATA133) on production server
In-Reply-To: <001d01c1e6e3$c2ef1e60$b4a6a8c0@si>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasja
I evaluated this board for linux server use. Stay away from it.
When you hook up and install the hpt raid, it corrupts disk files. This is 
100% reproducible.
The non hpt controller on board works ok.
I believe this is related to the via chipset problem with the PCI bus 
(doesn't allow bursts that are long enough for high bandwidth pci devices).

We went with i845 based Intel 845BG boards and p4/1.8GHz cpu. Cost 
difference is not much and performance was much better
If you like an athlon solution, Tyan's 2466N-4M AMD MPX based board works 
well too.

You can read about the via bug here...

http://www.tecchannel.de/hardware/817/index.html

I had this problem with KT133A and KT266A motherboards.

Email me if you want more info.
Thanks
Nick


At 04:16 PM 4/18/2002 +0200, Vasja J Zupan wrote:
>Hi,
>I'm buying a production server for webservices for mobile operators.
>
>My HW provider suggested Abit's KR7A-133R (ATA133)  with HPT372.
>
>Is this motherboard already fully supported and when will stable kernel be
>ready for production use on these motherboards? (btw - any advice on good
>amd combo is appreciated)
>
>Thank you for your help and I'd appreciate a personal cc: cos I'm not a
>member of this list.
>
>Thanx!
>Vasja
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

****************************************************
Nicolae P. Costescu, Ph.D.  / Senior Developer
Stronghold Technologies
46040 Center Oak Plaza, Suite 160 / Sterling, Va 20166
Tel: 571-434-1472 / Fax: 571-434-1478

