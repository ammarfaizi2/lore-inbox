Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261576AbTC0XXQ>; Thu, 27 Mar 2003 18:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261479AbTC0XXQ>; Thu, 27 Mar 2003 18:23:16 -0500
Received: from mta4-0.mail.adelphia.net ([64.8.50.184]:28323 "EHLO
	mta4.adelphia.net") by vger.kernel.org with ESMTP
	id <S261576AbTC0XXI>; Thu, 27 Mar 2003 18:23:08 -0500
Subject: Re: Adaptect 2940u2 w/ 2.4.20 or 2.5.59
From: "Anthony R. Mattke" <tonhe@adelphia.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <7930000.1048780898@aslan.scsiguy.com>
References: <1048727751.1225.10.camel@hiku.iphere.com>
	 <7930000.1048780898@aslan.scsiguy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048808055.264.2.camel@hiku.iphere.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 27 Mar 2003 18:34:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, this is the kernel message (i dont know of a good way to log these,
so i hand typed it from a laptop)

This is from booting the slackware9.0 install cd, i get the same panic
when booting 2.4.20 on my machine (the device not available because of
resource colissions is normal, i see that in 2.4.19 and everything seems
to work ok..)


Detecting Adaptec I20 RAID controllers...
PCI: Device 00:0b.1 not available because of resource collisions
PCI: Device 00:0b.0 not available because of resource collisions
Unable to handle kernel NULL pointer reference at virtual address
00000000
 printing eip:
c024e0db
*pde = 00000000
Oops: 0002
CPU:	0
EIP:	0010:[<c024e0db>]	Not tainted
EFLAGS: 00010246
eax: 00000000	ebx: cfda0c00	ecx: c033e974	edx: 00000000
esi: c033eae0	edi: cfdaf50	ebp: c0340718	esp: cfda7ec8
ds: 0018	es: 0018	ss: 0018
Process swapper (pid: 1, stackpage=cfda7000)
Stack: cfda0c00 cfd82a00 c02345d6 c033eae0 cfda0c00 cfd82a00 c022d562
cfd82a00
       5f636861 3a696370 31313a30 c000303a c12c5188 00000046 00000003
00000020
       c12c555c c12c5554 00000002 00000021 c012f276 c12c5554 00000002
00000244
Call Trace:    [<c02345d6>] [<c022d562>] [<c012f276>] [<c0214599>]
[<c024e031>]
  [<c024e0c7>] [<c022d5fb>] [<c0228ebb>] [<c0105000>] [<c0213651>]
[<c0105000>]
  [<c010503b>] [<c0104000>] [<c0107416>] [<c0105030>]

Code: 89 02 c7 06 00 00 00 00 8b 1d e8 0c 34 c0 81 fb e8 0c 34 c0
 <0>Kernel Panic: Attempted to kill init! 

let me know if you need anything else.. I really appreciate the help..
and yeah.. sorry about the typos.. It was late when I wrote the first
email and Adaptec seemed to be a hard word to type at the time.


Thanks for the help !

On Thu, 2003-03-27 at 11:01, Justin T. Gibbs wrote:
> > I have a current linux desktop curring 2.4.19 that has been running fine
> > for ever. Altho, when I atempted to do an update to 2.4.20, I was rather
> > surprised to see that my machine kernel panics on boot, just as it would
> > normally init the scsi bus.
> 
> What is the panic?
> 
> --
> Justin
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Anthony R. Mattke <tonhe@adelphia.net>

