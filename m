Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144244AbRA1VyB>; Sun, 28 Jan 2001 16:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143948AbRA1Vxo>; Sun, 28 Jan 2001 16:53:44 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:3347 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S144286AbRA1VxQ>;
	Sun, 28 Jan 2001 16:53:16 -0500
Message-ID: <3A7494B1.70799C19@mandrakesoft.com>
Date: Sun, 28 Jan 2001 16:52:49 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Dieter Nützel <Dieter.Nuetzel@hamburg.de>,
        Andrew Grover <andrew.grover@intel.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.1-pre11
In-Reply-To: <Pine.LNX.4.10.10101281346030.4151-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sun, 28 Jan 2001, Dieter Nützel wrote:
> > > I just uploaded it to kernel.org, and I expect that I'll do the final
> > > 2.4.1 tomorrow, before leaving for NY and LinuxWorld. Please test that the
> > > pre-kernel works for you..
> >
> > Hello Linus,
> >
> > can we please see Andrew's latest ACPI fixes ([Acpi] ACPI source release
> > updated: 1-25-2001)  in 2.4.1 final?
> 
> Does it fix stuff? Andrew?

I'm running it here..  No problems yet on my Toshiba test laptop, which
is the same behavior (for me) on 2.4.0-pre10 vanilla.

ACPI changelog, from
http://developer.intel.com/technology/IAPC/acpi/index.htm follows...


> Summary of changes for this label: 01_25_01
> 
> Core ACPI CA Subsystem:
> Restructured the implementation of object store support within the 
> interpreter.  This includes support for the Store operator as well
> as any ASL operators that include a target operand.
> 
> Partially implemented support for Implicit Result-to-Target conversion.
> This is when a result object is converted on the fly to the type of
> an existing target object.  Completion of this support is pending
> further analysis of the ACPI specification concerning this matter.
> 
> CPU-specific code has been removed from the subsystem (hardware directory).
> 
> New Power Management Timer functions added
> 
> Linux OS Services Layer (OSL):
> Moved system state transition code to the core, fixed it, and modified
> Linux OSL accordingly.
> 
> Fixed C2 and C3 latency calculations.
> 
> We no longer use the compilation date for the version message on
> initialization, but retrieve the version from AcpiGetSystemInfo().
> 
> Incorporated for fix Sony VAIO machines.
> 
> Documentation:
> The Programmer Reference has been updated and reformatted.
> 
> ASL Compiler:
> Version X2013:
> Fixed a problem where the line numbering and error reporting could get out
> of sync in the presence of multiple include files.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
