Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWIHSZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWIHSZx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWIHSZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:25:53 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:46609 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751153AbWIHSZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:25:51 -0400
Date: Fri, 08 Sep 2006 19:06:19 +0100
From: Darren Salt <linux@youmustbejoking.demon.co.uk>
To: dtor@insightbb.com
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: Touchpad sometimes detected twice
Message-ID: <4E634298D5%linux@youmustbejoking.demon.co.uk>
References: <4E623F81FD%linux@youmustbejoking.demon.co.uk> <200609062216.30904.dtor@insightbb.com> <4E62CC4533%linux@youmustbejoking.demon.co.uk> 
 <200609071945.13418.dtor@insightbb.com>
In-Reply-To: <200609071945.13418.dtor@insightbb.com>
User-Agent: Messenger-Pro/4.12 (MsgServe/3.25) (RISC-OS/4.02) POPstar/2.06+cvs
X-Editor: Zap 1.47 (27 Apr 2006) [TEST], ZapEmail 0.28.3 (25 Mar 2005) (32)
X-SDate: Fri, 4756 Sep 1993 19:06:19 +0100
X-Message-Flag: Outlook Express is broken. Upgrade to mail(1).
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1705064050--487932108--1079407676"
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: linux@youmustbejoking.demon.co.uk
X-SA-Exim-Scanned: No (on pentagram.youmustbejoking.demon.co.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format which your mailer apparently does not support.
You either require a newer version of your software which supports MIME, or
a separate MIME decoding utility.  Alternatively, ask the sender of this
message to resend it in a different format.

--1705064050--487932108--1079407676
Content-Type: text/plain; charset=us-ascii

I demand that Dmitry Torokhov may or may not have written...

> On Thursday 07 September 2006 16:33, Darren Salt wrote:
>> I demand that Dmitry Torokhov may or may not have written...
>>> On Wednesday 06 September 2006 14:56, Darren Salt wrote:
>>>> Sometimes, the touchpad on my (new) laptop is detected twice. This can
>>>> cause problems with udev [...]. Config etc. attached.
>>> Hmm, you could try booting with i8042.nomux.
>> Now tried, and added to the boot command line; so far, the problem hasn't
>> reappeared.

FWIW, it's still not reappearing. I'm assuming that this workaround is
sufficient.

>>> Does this laptop have external PS/2 ports?
>> No.

> May I have the output of dmidecode utility so we can blacklist MUX mode
> for that particular laptop please?

Vendor = "TOSHIBA"
Model = "EQUIUM A110"

More info is attached, but the above should be enough.

-- 
| Darren Salt    | linux or ds at              | nr. Ashington, | Toon
| RISC OS, Linux | youmustbejoking,demon,co,uk | Northumberland | Army
| + Buy less and make it last longer.         INDUSTRY CAUSES GLOBAL WARMING.

Hell's broken loose.

--1705064050--487932108--1079407676
Content-Type: text/plain; charset=iso-8859-1; name="dmi.txt"
Content-Disposition: attachment; filename="dmi.txt"
Content-Transfer-Encoding: quoted-printable

# dmidecode 2.8
SMBIOS 2.4 present.
23 structures occupying 965 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: TOSHIBA
	Version: V1.30
	Release Date: 07/20/2006
	Address: 0xE5B80
	Runtime Size: 107648 bytes
	ROM Size: 512 kB
	Characteristics:
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		Japanese floppy for Toshiba 1.2 MB is supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		AGP is supported
		Smart battery is supported
		BIOS boot specification is supported

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: TOSHIBA
	Product Name: EQUIUM A110
	Version: PSAB2E-002006AV
	Serial Number: [removed]
	UUID: [removed]
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: TOSHIBA
	Product Name: HTW20
	Version: Null
	Serial Number: 0123456789AB

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: TOSHIBA
	Type: Notebook
	Lock: Not Present
	Version: N/A
	Serial Number: None
	Asset Tag: *
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: U2E1
	Type: Central Processor
	Family: Other
	Manufacturer: Intel
	ID: E8 06 00 00 FF FB E9 AF
	Version: Genuine Intel(R) CPU           T1
	Voltage: 3.3 V
	External Clock: Unknown
	Max Speed: 2048 MHz
	Current Speed: 1860 MHz
	Status: Populated, Enabled
	Upgrade: ZIF Socket
	L1 Cache Handle: 0x0005
	L2 Cache Handle: 0x0006
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

[snip]

Handle 0x000B, DMI type 11, 5 bytes
OEM Strings
	String 1: PSAB2E-002006AV,SSAB2002006AV

[snip]

--1705064050--487932108--1079407676--
