Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273796AbRJ0RvR>; Sat, 27 Oct 2001 13:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273854AbRJ0RvI>; Sat, 27 Oct 2001 13:51:08 -0400
Received: from femail23.sdc1.sfba.home.com ([24.0.95.148]:43949 "EHLO
	femail23.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S273796AbRJ0Ru5>; Sat, 27 Oct 2001 13:50:57 -0400
Message-ID: <3BDAF334.93A1B465@home.com>
Date: Sat, 27 Oct 2001 13:47:32 -0400
From: John Gluck <jgluckca@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roel Teuwen <Roel.Teuwen@advalvas.be>
CC: Rob MacGregor <rob_macgregor@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.13 and ACPI not working (HP Omnibook 6000)
In-Reply-To: <F59K4GB7DEEbRQwGF5u0001425c@hotmail.com> <1004178427.3496.5.camel@omniroel>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Something seems to be broken, I had it working in 2.4.10 and 2.4.9
With 2.4.13 on boot I get:

Oct 24 15:09:19 tachyon kernel: Total of 2 processors activated (1798.96 BogoMIPS).
Oct 24 15:09:19 tachyon kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
Oct 24 15:09:19 tachyon kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Oct 24 15:09:19 tachyon kernel: testing the IO APIC.......................
Oct 24 15:09:19 tachyon kernel: .................................... done.

[snipped irrelevant stuff]

Oct 24 15:09:19 tachyon kernel: ACPI: Core Subsystem version [20010831]
Oct 24 15:09:19 tachyon kernel: ACPI: Subsystem enabled

When I try to start acpid I get:

john:~/download/lexmark> sudo /sbin/acpid
Password:
acpid: ACPI is not present
john:~/download/lexmark> uname -a
Linux tachyon 2.4.13 #2 SMP Wed Oct 24 13:40:05 EDT 2001 i686 unknown

John

Roel Teuwen wrote:

> Hi,
>
> I am seeing the exact same problem on my OB 6000, I think it's because
> of a buggy bios. I upgraded to the latest version (1.80 [1 okt 2001])
> but this doesn't help.
>
> regards,
>
> Roel
>
> On Thu, 2001-10-25 at 14:56, Rob MacGregor wrote:
> > System is an HP Omnibook 6000 laptop, using the provided BIOS.  Kernel
> > 2.4.13 with ACPI enabled as a module.
> >
> > On boot, with the debug enabled I get:
> >
> > tbxface-0107 [01] Acpi_load_tables      : ACPI Tables successfully loaded
> > Parsing
> > Methods:............................................................................................................................................................................................................................................................................................................
> > 300 Control Methods found and parsed (1046 nodes total)
> > ACPI Namespace successfully loaded at root c02d03c0
> > ACPI: Core Subsystem version [20010831]
> > evregion-0217 [22] Ev_address_space_dispa: no handler for region(c184cea8)
> > [PCIConfig]
> > exfldio-0222 [21] Ex_read_field_datum   : Region PCIConfig(2) has no handler
> > evregion-0217 [22] Ev_address_space_dispa: no handler for region(c184cea8)
> > [PCIConfig]
> > exfldio-0597 [21] Ex_write_field_datum  : **** Region type PCIConfig(2) does
> > not have a handler
> > ACPI: Subsystem enable failed
> >
> > This is certainly an improvement over previous kernels, however I'd like to
> > get it working.  Any thoughts or is this in the hands of those who
> > understand such things?
> >
> > Thanks.
> >
> > Oh, I'm not on the list, but I will see any replies on the archive.  If you
> > want a faster response you'll need to CC me.
> >
> > --
> > Rob  |  Please ask questions the smart way:
> >                 http://www.tuxedo.org/~esr/faqs/smart-questions.html
> >
> >     Please don't CC me on anything sent to mailing lists or send
> >         me email directly unless it's a privacy issue, thanks.
> >
> >
> >
> > _________________________________________________________________
> > Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

