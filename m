Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbUKMR1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUKMR1u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 12:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbUKMR1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 12:27:50 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:62656 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S261611AbUKMR1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 12:27:47 -0500
Date: Sat, 13 Nov 2004 09:27:46 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Enrico Bartky <DOSProfi@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: New HDD (was RE: PROMISE Ultra133 TX2 (PDC20269))
In-Reply-To: <683978599@web.de>
Message-ID: <Pine.LNX.4.61.0411130920360.25441@twin.uoregon.edu>
References: <683978599@web.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Nov 2004, Enrico Bartky wrote:

> Now I have attached a 80 GB UDMA5 Disk. The hdparm putput says the right 
> UDMA Mode (5). But the hdparm test, I run it 3 times, says 27 MByte/s!? 
> Is that normal, or is my motherboard ( Gigabyte GA-5AA ) to old ( PCI 
> Bus = 33 MHz ). In the manuel from promise there is it described that 33 
> MHz have bandwith of 133 MByte/s and with 66 MHz 266 MByte/s.

27MB/s is reasonable for a 7200rpm ide disk that isn't totaly state of the 
art (ie 100GB per platter or something). what were you expecting? That's a 
pentium era mainboard is it not?

a similar disk (40GB single platter wester digital 7200rpm) in and amd 64 
box I have is:

[root@twin joelja]# hdparm -t /dev/hda

/dev/hda:
  Timing buffered disk reads:  102 MB in  3.05 seconds =  33.43 MB/sec

the sata 80GB per platter disk in the same box is:

[root@twin joelja]# hdparm -t /dev/sda1

/dev/sda1:
  Timing buffered disk reads:  150 MB in  3.02 seconds =  49.71 MB/sec


> Can you help me, how can I get more transfer rates?
>
> Thanx, EnricoB
> ________________________________________________________________
> Verschicken Sie romantische, coole und witzige Bilder per SMS!
> Jetzt neu bei WEB.DE FreeMail: http://freemail.web.de/?mc=021193
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu 
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

