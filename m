Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVDPK6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVDPK6g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 06:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVDPK6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 06:58:36 -0400
Received: from smtp1.poczta.interia.pl ([217.74.65.44]:35395 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S261998AbVDPK6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 06:58:30 -0400
Message-ID: <4260EFCA.5040100@interia.pl>
Date: Sat, 16 Apr 2005 12:58:18 +0200
From: Tomasz Chmielewski <mangoo@interia.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
Cc: Andre Tomt <andre@tomt.net>, linux-kernel@vger.kernel.org
Subject: Re: [SATA] status reports updated
References: <3THXg-6HX-5@gated-at.bofh.it> <3THXg-6HX-7@gated-at.bofh.it> <3THXg-6HX-9@gated-at.bofh.it> <3THXg-6HX-11@gated-at.bofh.it> <3THXg-6HX-3@gated-at.bofh.it> <E1DMaM1-0001WQ-C6@be1.7eggert.dyndns.org>
In-Reply-To: <E1DMaM1-0001WQ-C6@be1.7eggert.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-EMID: 25394acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> 
>>Tomasz Chmielewski <mangoo@interia.pl> wrote:
> 
> 
>>>Is there a way to check what firmware a drive has
>>
>>The obvious one: hdparm
> 
> 
> <Ingrid>
> Or, since hdparm doesn't work for SCSI devices,
> cat /sys/block/sd$n/device/rev
> 
> (might depend on the vendor)

Oh, indeed!

# cat /sys/block/sda/device/rev
3.01

So what about SATA blacklisting based on a model/firmware version rather 
than on a model only?

My model (ST3200822AS) is blacklisted, though I'm stress-testing it for 
the second day and nothing happened, so I assume I may not be affected.

The question is, if I'm not affected because:
1) I'm lucky and it didn't happen yet,
2) hard drive (ST3200822AS) firmware is better - is anyone in contact 
with Seagate?
3) SATA controller (Silicon Image SiI 3112) BIOS is better - is anyone 
in contact with Silicon Image?


Additional question: is there a way to check the SATA controller BIOS as 
easily as it is with the drive firmware?


Tomek

----------------------------------------------------------------------
Startuj z INTERIA.PL! >>> http://link.interia.pl/f186c 

