Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267451AbTACGkh>; Fri, 3 Jan 2003 01:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267453AbTACGkh>; Fri, 3 Jan 2003 01:40:37 -0500
Received: from tag.witbe.net ([81.88.96.48]:46601 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S267451AbTACGkf>;
	Fri, 3 Jan 2003 01:40:35 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Steven Barnhart'" <sbarn03@softhome.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.54] OOPS: unable to handle kernel paging request
Date: Fri, 3 Jan 2003 07:49:03 +0100
Message-ID: <004a01c2b2f4$350bb800$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <pan.2003.01.03.00.08.53.924016@softhome.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got the same yesterday evening when installing 2.5.54 for the first
time....

My second PC which I used for Serial console was not at home,
so if a console output is needed, people will have to wait
for the weekend (which is not that far).

Config was roughly including :
 - Arch = P4, Unipro, APIC
 - CPU Freq scaling
 - ACPI (enum only)
 - TCP (v4 + v6), Netfilter
 - IDE, SCSI (AIC7xxx),
 - Sound (Alsa, EMu10K1),
 - Crypto

This oops happens at the very early stage of the boot process.
By that time, only 10 to 15 lines are displayed on the screen
following the "Booting ...................." stuff.

Regards,
Paul Rolland, rol@as2917.net

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Steven Barnhart
> Sent: Friday, January 03, 2003 1:09 AM
> To: linux-kernel@vger.kernel.org
> Subject: [2.5.54] OOPS: unable to handle kernel paging request
> 
> 
> Hello,
> 
> I seem to get a very nasty oops exactly when booting 2.5.54. 
> When i boot to the kernel I immediately get a kksymoops 
> report flooding my screen. This happens to fast that the text 
> blurs and basically everything stays where its at. There is 
> no way to stop it except rebooting. I do not have any serial 
> connections to send the output to so I got (hopefully) the 
> most important line. The oops says "unable to handle kernel 
> paging request at virtual address ffffff8d (there may be 
> another 'f' in there). I searched through the archives and 
> their seems to be a few oops reports of the same kind but no 
> patches and the only kernel was 2.5.48-bk I think. Any thoughts?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

