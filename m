Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267444AbTACIZA>; Fri, 3 Jan 2003 03:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267472AbTACIZA>; Fri, 3 Jan 2003 03:25:00 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:24284 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267444AbTACIY7> convert rfc822-to-8bit; Fri, 3 Jan 2003 03:24:59 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2.5.54] OOPS: unable to handle kernel paging request
Date: Fri, 3 Jan 2003 14:03:16 +0530
Message-ID: <94F20261551DC141B6B559DC49108672044910@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.5.54] OOPS: unable to handle kernel paging request
Thread-Index: AcKy9PSSb6aCR6TcSy2EvR2R9nva+QADUNsw
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: "Paul Rolland" <rol@as2917.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Jan 2003 08:33:17.0024 (UTC) FILETIME=[C373AE00:01C2B302]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Paul Rolland [mailto:rol@as2917.net] 
>Subject: Re: [2.5.54] OOPS: unable to handle kernel paging request
>
>
>Got the same yesterday evening when installing 2.5.54 for the 
>first time....
>
>My second PC which I used for Serial console was not at home, 
>so if a console output is needed, people will have to wait for 
>the weekend (which is not that far).
>
>Config was roughly including :
> - Arch = P4, Unipro, APIC
> - CPU Freq scaling
> - ACPI (enum only)
> - TCP (v4 + v6), Netfilter
> - IDE, SCSI (AIC7xxx),
> - Sound (Alsa, EMu10K1),
> - Crypto
>
>This oops happens at the very early stage of the boot process. 
>By that time, only 10 to 15 lines are displayed on the screen 
>following the "Booting ...................." stuff.
>
>
Check if the processor in your .config matches with the processor that you have.
Eg. Problme might arise if .config file says CONFIG_MPENTIUMIII=y when your processor is P4.
