Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSL2V6W>; Sun, 29 Dec 2002 16:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSL2V6W>; Sun, 29 Dec 2002 16:58:22 -0500
Received: from tag.witbe.net ([81.88.96.48]:12296 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S261836AbSL2V6M>;
	Sun, 29 Dec 2002 16:58:12 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Andrew Walrond'" <andrew@walrond.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.53] So sloowwwww......
Date: Sun, 29 Dec 2002 23:06:32 +0100
Message-ID: <00d901c2af86$8be90d60$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <3E0F63FD.60903@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I did made another kernel without ACPI and with APM, 
and it is working fine.

To summarize :
 - ACPI Enumeration only is fine
 - More functionnalities from ACPI is bad.

If someone has an idea and wants me to make tests, please contact
me...

Regards,
Paul

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Andrew Walrond
> Sent: Sunday, December 29, 2002 10:07 PM
> To: Paul Rolland
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [2.5.53] So sloowwwww......
> 
> 
> Mount a tmpfs drive and try building the kernel there to rule 
> out scsi 
> or disc issues. (You've got .5Gb I think? Might not want to 
> run kde as 
> well; just build from a console)
> 
> But I think your ACPI guess is probably not far wrong.
> 
> Paul Rolland wrote:
> > Hello,
> > 
> > 
> >>Ouch; that is slow. What partition type are you building from ?
> >>
> > 
> > This is an ext3 partition, and a SCSI disk :
> > 4 [18:10] rol@donald:/kernels> df .
> > Filesystem           1K-blocks      Used Available Use% Mounted on
> > /dev/sda1             10320888    753828   9042724   8% /kernels
> > 
> > Do you think I should try on some other ?
> > The problem is that the system is *globally* slow, and 
> compiling the 
> > kernel is just a way to prove it. Starting KDE has become a 
> real pain 
> > (so slow screen detects no more video and enter Energy Saving mode 
> > before reactivating and switching to Graphic mode).
> > 
> > Regards,
> > Paul
> > 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

