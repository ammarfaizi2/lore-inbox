Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265387AbSJPRQc>; Wed, 16 Oct 2002 13:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265388AbSJPRQc>; Wed, 16 Oct 2002 13:16:32 -0400
Received: from telus-2.cdlsystems.com ([142.179.183.92]:20987 "EHLO
	cdlsystems.com") by vger.kernel.org with ESMTP id <S265387AbSJPRQ3>;
	Wed, 16 Oct 2002 13:16:29 -0400
Message-ID: <077901c27538$ef71b4a0$2c0e10ac@frinkiac7>
From: "Mark Cuss" <mcuss@cdlsystems.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel reports 4 CPUS instead of 2...
Date: Wed, 16 Oct 2002 11:24:51 -0600
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0776_01C27506.A4CDCEC0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Return-Path: mcuss@cdlsystems.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: mcuss@cdlsystems.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0776_01C27506.A4CDCEC0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello all

I'm working with a new Dell Poweredge 4600 Server with Dual CPUs.  However,
Linux reports that it sees 4 CPUs...  I have opened the thing to see if Dell
gave me 2 extras for free, but no luck:  Attached is /proc/cpuinfo.

I've tried the RedHat 8.0 stock kernel, as well as a freshly compiled 2.4.19
but both exhibit the same behavior.

The specifics on the machine:

Dual Xeon 2.2 GHz CPUs (512 k L2 cache)
2 Gigs DDR RAM
The chipset is a ServerWorks CMIC-HE (see attached lspci for complete
listing).

Has anyone else seen this behavior?  The only other SMP machine I have is an
older Dell server with Dual 1 GHz coppermines, and it reports 2 CPUs...

Any information or advice is greatly appreciated...

Thanks in Advance,

Mark


Mark Cuss
Real Time Systems Analyst
CDL Systems Ltd.
Suite 230
3553 - 31 Street NW
Calgary, Alberta
T2L 2K7

Phone (403) 289-1733 extension 226
Email:  mcuss@cdlsystems.com
URL: www.cdlsystems.com

------=_NextPart_000_0776_01C27506.A4CDCEC0
Content-Type: application/octet-stream;
	name="pe4600"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pe4600"

processor	: 0=0A=
vendor_id	: GenuineIntel=0A=
cpu family	: 15=0A=
model		: 2=0A=
model name	: Intel(R) XEON(TM) CPU 2.20GHz=0A=
stepping	: 4=0A=
cpu MHz		: 2190.049=0A=
cache size	: 512 KB=0A=
fdiv_bug	: no=0A=
hlt_bug		: no=0A=
f00f_bug	: no=0A=
coma_bug	: no=0A=
fpu		: yes=0A=
fpu_exception	: yes=0A=
cpuid level	: 2=0A=
wp		: yes=0A=
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm=0A=
bogomips	: 4364.69=0A=
=0A=
processor	: 1=0A=
vendor_id	: GenuineIntel=0A=
cpu family	: 15=0A=
model		: 2=0A=
model name	: Intel(R) XEON(TM) CPU 2.20GHz=0A=
stepping	: 4=0A=
cpu MHz		: 2190.049=0A=
cache size	: 512 KB=0A=
fdiv_bug	: no=0A=
hlt_bug		: no=0A=
f00f_bug	: no=0A=
coma_bug	: no=0A=
fpu		: yes=0A=
fpu_exception	: yes=0A=
cpuid level	: 2=0A=
wp		: yes=0A=
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm=0A=
bogomips	: 4377.80=0A=
=0A=
processor	: 2=0A=
vendor_id	: GenuineIntel=0A=
cpu family	: 15=0A=
model		: 2=0A=
model name	: Intel(R) XEON(TM) CPU 2.20GHz=0A=
stepping	: 4=0A=
cpu MHz		: 2190.049=0A=
cache size	: 512 KB=0A=
fdiv_bug	: no=0A=
hlt_bug		: no=0A=
f00f_bug	: no=0A=
coma_bug	: no=0A=
fpu		: yes=0A=
fpu_exception	: yes=0A=
cpuid level	: 2=0A=
wp		: yes=0A=
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm=0A=
bogomips	: 4377.80=0A=
=0A=
processor	: 3=0A=
vendor_id	: GenuineIntel=0A=
cpu family	: 15=0A=
model		: 2=0A=
model name	: Intel(R) XEON(TM) CPU 2.20GHz=0A=
stepping	: 4=0A=
cpu MHz		: 2190.049=0A=
cache size	: 512 KB=0A=
fdiv_bug	: no=0A=
hlt_bug		: no=0A=
f00f_bug	: no=0A=
coma_bug	: no=0A=
fpu		: yes=0A=
fpu_exception	: yes=0A=
cpuid level	: 2=0A=
wp		: yes=0A=
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm=0A=
bogomips	: 4377.80=0A=
=0A=

------=_NextPart_000_0776_01C27506.A4CDCEC0
Content-Type: application/octet-stream;
	name="lspci"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lspci"

00:00.0 Host bridge: ServerWorks CMIC-HE (rev 22)=0A=
00:00.1 Host bridge: ServerWorks CMIC-HE=0A=
00:00.2 Host bridge: ServerWorks CMIC-HE=0A=
00:00.3 Host bridge: ServerWorks CMIC-HE=0A=
00:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] =
(rev 08)=0A=
00:06.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891 (rev =
01)=0A=
00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)=0A=
00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)=0A=
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)=0A=
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05)=0A=
00:0f.3 ISA bridge: ServerWorks: Unknown device 0225=0A=
00:10.0 Host bridge: ServerWorks CIOB30 (rev 03)=0A=
00:10.2 Host bridge: ServerWorks CIOB30 (rev 03)=0A=
00:11.0 Host bridge: ServerWorks CIOB30 (rev 03)=0A=
00:11.2 Host bridge: ServerWorks CIOB30 (rev 03)=0A=
01:06.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5700 =
Gigabit Ethernet (rev 14)=0A=
01:08.0 PCI bridge: Intel Corp.: Unknown device 0309 (rev 01)=0A=
02:06.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)=0A=
02:06.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)=0A=

------=_NextPart_000_0776_01C27506.A4CDCEC0--

