Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130277AbRANIDw>; Sun, 14 Jan 2001 03:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130219AbRANIDl>; Sun, 14 Jan 2001 03:03:41 -0500
Received: from smtp-rt-10.wanadoo.fr ([193.252.19.59]:23019 "EHLO
	camelia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130070AbRANIDa>; Sun, 14 Jan 2001 03:03:30 -0500
Message-ID: <3A615D6D.AF2E8982@wanadoo.fr>
Date: Sun, 14 Jan 2001 09:03:57 +0100
From: LAMBERT Bernard <bga.lambert@wanadoo.fr>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: lp with kernel 2.2.18
Content-Type: multipart/mixed;
 boundary="------------1703EB9E6B043B583627FE56"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1703EB9E6B043B583627FE56
Content-Type: multipart/alternative;
 boundary="------------508301085F7843201D5D1A00"


--------------508301085F7843201D5D1A00
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

i don't know if it is a bug but I report it

Mother board gigabytes GA 7ZX (via chipset)
Duron 700 Mhz

I have attached file which give information to kernel, modules and so on

The initial version of kernel whas built with Suse 6.4 distrib and it is
a 2.2.14 kernel patched for Dvd

Kde is 1.1
XFree is 4.01

description of bug :

If i use kernel 2.2.14 at boot i can use lpd without problems, all
queues are working

if i use my new kernel 2.2.18 , i can print and /dev/lp0, lp1 are
présent

It looks like kernel  dont communicate with the socket printer ?
the error message at boot time is in the attached file boot.txt

regards


--------------508301085F7843201D5D1A00
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>

<pre>Hi,

i don't know if it is a bug but I report it</pre>
Mother board gigabytes GA 7ZX (via chipset)
<br>Duron 700 Mhz
<p>I have attached file which give information to kernel, modules and so
on
<p>The initial version of kernel whas built with Suse 6.4 distrib and it
is a 2.2.14 kernel patched for Dvd
<p>Kde is 1.1
<br>XFree is 4.01
<p>description of bug :
<p>If i use kernel 2.2.14 at boot i can use lpd without problems, all queues
are working
<p>if i use my new kernel 2.2.18 , i can print and /dev/lp0, lp1 are pr&eacute;sent
<p>It looks like kernel&nbsp; dont communicate with the socket printer
?
<br>the error message at boot time is in the attached file boot.txt
<p>regards
<br>&nbsp;</html>

--------------508301085F7843201D5D1A00--

--------------1703EB9E6B043B583627FE56
Content-Type: text/plain; charset=us-ascii;
 name="boot.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot.txt"

Jan 14 07:53:47 bl modprobe: modprobe: Can't locate module char-major-5
Jan 14 08:00:51 bl modprobe: modprobe: Can't locate module char-major-6 

--------------1703EB9E6B043B583627FE56
Content-Type: text/plain; charset=us-ascii;
 name="cpu.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpu.txt"

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 3
model name	: AMD Athlon(tm) Processor
stepping	: 0
cpu MHz		: 701.614
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 psn mmxext mmx fxsr 3dnowext 3dnow
bogomips	: 1399.19


--------------1703EB9E6B043B583627FE56
Content-Type: text/plain; charset=us-ascii;
 name="linux.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux.txt"

-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux bl 2.2.18 #13 sam jan 13 21:46:04 CET 2001 i686 unknown
Kernel modules         2.3.9
Gnu C                  2.95.2
Binutils               2.9.5.0.24
Linux C Library        x   1 root     root      4060896 Sep  5 13:57 /lib/libc.so.6
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10f
Net-tools              1.54
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         usb-uhci usbcore ne2k-pci 8390 hisax isdn slhc apci97 audiobuf pnp midi ac97 soundbase sndshield

--------------1703EB9E6B043B583627FE56
Content-Type: text/plain; charset=us-ascii;
 name="modules.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modules.txt"

usb-uhci               19044   0 (unused)
usbcore                26436   0 [usb-uhci]
ne2k-pci                4232   1 (autoclean)
8390                    6228   0 (autoclean) [ne2k-pci]
hisax                 135488   3
isdn                  113716   4 [hisax]
slhc                    4500   1 [isdn]
apci97                 13784   0
audiobuf               10792   0 [apci97]
pnp                    49552   0 [apci97]
midi                   28228   0 [apci97 pnp]
ac97                    5256   0 [apci97]
soundbase             313956   0 [apci97 audiobuf pnp midi ac97]
sndshield               5684   0 [apci97 audiobuf pnp midi ac97 soundbase]

--------------1703EB9E6B043B583627FE56
Content-Type: text/plain; charset=us-ascii;
 name="scsi.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi.txt"

Attached devices: 
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: Seagate  Model: STT8000N         Rev: 3.22
  Type:   Sequential-Access                ANSI SCSI revision: 02

--------------1703EB9E6B043B583627FE56
Content-Type: text/plain; charset=us-ascii;
 name="version.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="version.txt"

Linux version 2.2.18 (root@bl) (gcc version 2.95.2 19991024 (release)) #13 sam jan 13 21:46:04 CET 2001

--------------1703EB9E6B043B583627FE56
Content-Type: text/x-vcard; charset=us-ascii;
 name="bga.lambert.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for LAMBERT Bernard
Content-Disposition: attachment;
 filename="bga.lambert.vcf"

begin:vcard 
n:LAMBERT;Bernard
tel;cell:0680177210
tel;home:0169833795
x-mozilla-html:FALSE
adr:;;4 rue des primeveres;YERERS;;91330;FRANCE
version:2.1
email;internet:bga.lambert@wanadoo.fr
note;quoted-printable:Close the windows and the gate,=0D=0AOpen you mind ,=0D=0Athink innovation=0D=0Athink linux or Unix
x-mozilla-cpt:;-16160
fn:LAMBERT bernard
end:vcard

--------------1703EB9E6B043B583627FE56--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
