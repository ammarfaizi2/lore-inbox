Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRCCV4I>; Sat, 3 Mar 2001 16:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129774AbRCCVz7>; Sat, 3 Mar 2001 16:55:59 -0500
Received: from b1.ovh.net ([213.186.33.51]:51439 "HELO ns0.ovh.net")
	by vger.kernel.org with SMTP id <S129771AbRCCVzu>;
	Sat, 3 Mar 2001 16:55:50 -0500
From: "Stephane GARIN" <sgarin@sgarin.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: 2.2.19pre - Kernel Panic: no init found
Date: Sat, 3 Mar 2001 22:50:37 +0100
Message-ID: <001f01c0a42c$7fc2e810$4601a8c0@oracle.intranet>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.21.0103031334340.11559-100000@spock.shacknet.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3612.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried it but no change. I don't have ACPI messages during the boot... I
don't understand why there is this trouble...

-----Message d'origine-----
De : linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]De la part de Jason Madden
Envoyé : samedi 3 mars 2001 20:44
À : linux-kernel@vger.kernel.org
Objet : Re: 2.2.19pre - Kernel Panic: no init found


I get similar messages on 2.4.2 and 2.4.2-ac7 :

...
ACPI: Core Subsystem version [20010208]
ACPI: Subsystem enabled
ACPI: System firmware supports: C2 C3
ACPI: plvl2lat=10 plvl3lat=20
ACPI: C2 enter=143 C2 exit=35
ACPI: C3 enter=858 C3 exit=71
ACPI: Not using ACPI idle
ACPI: System firmware supports: S0 S1 S5
ACPI: If experiencing system slowdowns, pass acpi=no-idle #FROM MEMORY
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 232k freed
Kernel  panic: No init found. Try passing init= option to kernel.

The solution was to pass acpi=no-idle on the kernel command line. The same
configuration worked fine with 2.4.1

Jason


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

