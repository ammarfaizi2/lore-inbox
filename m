Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEHpc>; Fri, 5 Jan 2001 02:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAEHpW>; Fri, 5 Jan 2001 02:45:22 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:5125 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129183AbRAEHpI>; Fri, 5 Jan 2001 02:45:08 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE572@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'safemode'" <safemode@voicenet.com>, linux-kernel@vger.kernel.org
Cc: "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: RE: ACPI in Via Apollo (vt82C686) broken badly in 2.4.x ?
Date: Thu, 4 Jan 2001 23:45:02 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: safemode [mailto:safemode@voicenet.com]

> Well, it seems the only way to look at sensor readings with 
> lmsensors is
> to activate acpi in linux for my motherboard.

Can you please send me the output from dmesg, as well as /proc/interrupts? I
don't think anyone's tried lmsensors and acpi. It may be that they will need
some work to coexist..

> According to 
> the docs, my
> motherboard is supposed to be supported and is detected when linux
> boots, the problem comes when i try to move the mouse (in console and
> X).  It totally flips out, i get irregular mouse movement across the
> screen and button clicks when i just barely touched it.  It 
> is directly
> related to enabling acpi so i was wondering if anyone else 
> has had this
> problem and if there was/is a fix for it or if it's a bug right now.
> If there is specific debugging info that i can get to help, tell me
> where... dmesg just shows successful messages.

Never seen that before.. does /proc/interrupts indicate mouse driver and
acpi are sharing one?

Regards -- Andy (ACPI maintainer)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
