Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbRBMLtK>; Tue, 13 Feb 2001 06:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130320AbRBMLtA>; Tue, 13 Feb 2001 06:49:00 -0500
Received: from WebDev.iNES.RO ([193.226.161.26]:57987 "HELO webdev.ines.ro")
	by vger.kernel.org with SMTP id <S129592AbRBMLsr>;
	Tue, 13 Feb 2001 06:48:47 -0500
Date: Tue, 13 Feb 2001 13:48:10 +0200 (EET)
From: Umbra <shadow@webdev.ines.ro>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ACPI idle
In-Reply-To: <Pine.GSO.4.32.0102122111310.10120-100000@romulus.cs.ut.ee>
Message-ID: <Pine.LNX.4.30.0102131334230.8651-100000@webdev.ines.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

On Mon, 12 Feb 2001, Meelis Roos wrote:

I also tried 2.4.1-ac10, but without acpi=no-idle, my machine crashes.
Part of the output is bellow:

ACPI: Core Subsystem Version [20010208]
ACPI: Subsystem enabled
ACPI: System firmware supports: C2 C3
ACPI: plvl2lat=10 plvl3lat=20
ACPI: C2 enter=143 C2 exit=35
ACPI: C3 enter=858 C3 exit=71
ACPI: Using ACPI idle
ACPI: If experiencing system slowness, try adding "acpi=no-idle" to cmdline
ACPI: System firmware supports: S0 S1 S5
VFS: Mounted root (ex2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Warning: unable to open an initial console.
Kernel panic: No init found. Try passing init= option to kernel.

Until 2.4.1-ac3(than I skipped directyl to ac10), I had no problem with
acpi support(no slowness or anything else).
If I use acpi=no-idle, the system boots and works fine.

And another thing: I've noticed kacpid in the processlist. I tried
strace -p `pidof kacpid`, and kacpid died. Should I worry ?

I use an Intel PIII 550Mhz, MB: Intel with 440BX chipset(SE440BX-2).


Andrei Ivanov (andrei.ivanov@ines.ro)

