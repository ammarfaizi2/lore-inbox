Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWCERVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWCERVW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 12:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWCERVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 12:21:22 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:60126 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751045AbWCERVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 12:21:21 -0500
Message-ID: <440B1DF8.7050108@t-online.de>
Date: Sun, 05 Mar 2006 18:20:56 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.16-rc5: unreasonable temperature reported by w83627thf-isa-0290
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig69DA05EE8166A175ADC77655"
X-ID: JOwnl2ZfoeBSt4+ldzq57B-8OwpOzYBcelWgZe+VOy0c5DdZKIR5wN
X-TOI-MSGID: f20a5941-1578-4abb-af1b-504c27cf514f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig69DA05EE8166A175ADC77655
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi folks,

Configuring a barebone (Aopen MZ915-M) I tried the sensors stuff
today. After running sensors-detect this is what sensors reports:

w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.36 V  (min =  +1.94 V, max =  +1.94 V)       ALARM
+12V:     +12.28 V  (min = +10.82 V, max = +13.19 V)
+3.3V:     +3.18 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +4.93 V  (min =  +4.75 V, max =  +5.25 V)
-12V:     -12.11 V  (min = -13.18 V, max = -10.80 V)
V5SB:      +5.05 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +3.10 V  (min =  +2.40 V, max =  +3.60 V)
fan1:        0 RPM  (min =  664 RPM, div = 8)              ALARM
CPU Fan:     0 RPM  (min =  664 RPM, div = 8)              ALARM
fan3:        0 RPM  (min =  664 RPM, div = 8)              ALARM
M/B Temp:     +7 C  (high =   +45 C, hyst =  +101 C)   sensor = diode
CPU Temp:   -5.5 C  (high =   +80 C, hyst =   +75 C)   sensor = diode
temp3:      +7.5 C  (high =   +80 C, hyst =   +75 C)   sensor = diode           (beep)
alarms:
beep_enable:
          Sound alarm enabled

The voltage values seem to be the same as the bios displays.
The min/max values of VCore doesn't seem right to me.

M/B and CPU temperatures are unreasonable. Not to mention
the CPU fan. It is set to full speed in the bios.

Any ideas? Any help would be highly appreciated.


Regards

Harri
================================================================================
uname -a:
Linux bugs 2.6.16-rc5 #2 PREEMPT Sun Mar 5 16:22:06 CET 2006 i686 GNU/Linux

/proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 2.00GHz
stepping        : 8
cpu MHz         : 1995.371
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx est tm2
bogomips        : 3995.04


--------------enig69DA05EE8166A175ADC77655
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFECx39UTlbRTxpHjcRAloxAJ4ovnTA6h5ocEaAT2He0rijorfK1gCffmQf
EUkM+JCS1A2py/JOgqWljEM=
=1gjT
-----END PGP SIGNATURE-----

--------------enig69DA05EE8166A175ADC77655--
