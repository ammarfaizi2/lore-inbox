Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129703AbRAaK54>; Wed, 31 Jan 2001 05:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129780AbRAaK5q>; Wed, 31 Jan 2001 05:57:46 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:47085 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129703AbRAaK5c>;
	Wed, 31 Jan 2001 05:57:32 -0500
Date: Wed, 31 Jan 2001 11:57:02 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200101311057.LAA03114@harpo.it.uu.se>
To: ajschrotenboer@lycosmail.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4.1 Detects 64 MB RAM, actual 192MB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001 23:25:22 -0500, Adam Schrotenboer wrote:

>2.4.1 detects 64 MB, but 2.4.0 detects 192 (Maybe 191, not sure).
>...
>Linux version 2.4.1 (root@tabriel) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #9 Tue Jan 30 15:35:21 EST 2001
>BIOS-provided physical RAM map:
> BIOS-88: 000000000009f000 @ 0000000000000000 (usable)
> BIOS-88: 0000000003ff0000 @ 0000000000100000 (usable)
>On node 0 totalpages: 16624
>...
>CPU: AMD-K7(tm) Processor stepping 02
>...
>BIOS Vendor: Award Software International, Inc.
>BIOS Version: 6.0 PG
>BIOS Release: 11/23/99
>Board Vendor: MICRO-STAR INTERNATIONAL CO., LTD.
>Board Name: MS-6167 (AMD751).
>Board Version: 1.X.

Why on earth is this fairly recent motherboard using BIOS-88
to report available memory? I would have expected E820 here.
Can you send the dmesg output from 2.4.0 and/or 2.2.19pre7?

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
