Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAEUnP>; Fri, 5 Jan 2001 15:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRAEUnE>; Fri, 5 Jan 2001 15:43:04 -0500
Received: from acct2.voicenet.com ([207.103.26.205]:4510 "HELO voicenet.com")
	by vger.kernel.org with SMTP id <S129324AbRAEUmx>;
	Fri, 5 Jan 2001 15:42:53 -0500
Message-ID: <3A5631CB.C0E3E4C1@voicenet.com>
Date: Fri, 05 Jan 2001 15:42:52 -0500
From: safemode <safemode@voicenet.com>
Organization: none
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: linux-kernel@vger.kernel.org,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: ACPI in Via Apollo (vt82C686) broken badly in 2.4.x ?
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE572@orsmsx35.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" wrote:

> > From: safemode [mailto:safemode@voicenet.com]
>
> > Well, it seems the only way to look at sensor readings with
> > lmsensors is
> > to activate acpi in linux for my motherboard.
>
> Can you please send me the output from dmesg, as well as /proc/interrupts? I
> don't think anyone's tried lmsensors and acpi. It may be that they will need
> some work to coexist..
>
> > According to
> > the docs, my
> > motherboard is supposed to be supported and is detected when linux
> > boots, the problem comes when i try to move the mouse (in console and
> > X).  It totally flips out, i get irregular mouse movement across the
> > screen and button clicks when i just barely touched it.  It
> > is directly
> > related to enabling acpi so i was wondering if anyone else
> > has had this
> > problem and if there was/is a fix for it or if it's a bug right now.
> > If there is specific debugging info that i can get to help, tell me
> > where... dmesg just shows successful messages.
>
> Never seen that before.. does /proc/interrupts indicate mouse driver and
> acpi are sharing one?
>
> Regards -- Andy (ACPI maintainer)

The problem wasn't actually with lmsensors together with ACPI yet...  Just
enabling ACPI with this board causes the mouse to go insane.   i will however
recompile the stock 2.4.0 kernel that recently came out to test it again.  I'll
give you output from dmesg and /proc/interrupts before lmsensors is loaded and
after (after a new recompile of the drivers too).   I can tell you know though,
the acpi bus? is running on int 5 according to the bios.  ... Should have the
output ready within the hour.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
