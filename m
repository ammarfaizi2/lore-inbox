Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293485AbSCECMd>; Mon, 4 Mar 2002 21:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293490AbSCECMY>; Mon, 4 Mar 2002 21:12:24 -0500
Received: from huitzilopochtli.presidencia.gob.mx ([200.57.34.35]:40652 "EHLO
	huitzilopochtli.presidencia.gob.mx") by vger.kernel.org with ESMTP
	id <S293485AbSCECML>; Mon, 4 Mar 2002 21:12:11 -0500
Message-ID: <3C84294C.AE1E8CE9@sandino.net>
Date: Mon, 04 Mar 2002 20:11:24 -0600
From: Sandino Araico =?iso-8859-1?Q?S=E1nchez?= <sandino@sandino.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: es-MX, es, es-ES, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17,2.4.18 ide-scsi+usb-storage+devfs Oops
In-Reply-To: <3C7EA7CB.C36D0211@sandino.net> <20020302075847.GE20536@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------6B43C47FD26D40E1CBB2C618"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6B43C47FD26D40E1CBB2C618
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Greg KH wrote:

> On Thu, Feb 28, 2002 at 03:57:31PM -0600, Sandino Araico Sánchez wrote:
> > The Oops happens after I use the ide-scsi module with my CDRW and then I
> > plug the Zip USB in.
>
> Can you run the oops through ksymoops and send it to us?
>

ksymoops output attached.

--
Sandino Araico Sánchez
>drop table internet;
OK, 135454265363565609860398636678346496 rows affected.
"oh fuck" --fluxrad



--------------6B43C47FD26D40E1CBB2C618
Content-Type: text/plain; charset=us-ascii;
 name="Oops-2002-03-04.ksymoops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Oops-2002-03-04.ksymoops"

ksymoops 2.3.4 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (expand_objects): object /lib/modules/2.4.18/kernel/sound/acore/oss/snd-pcm-oss.o for module snd-pcm-oss has changed since load
Warning (expand_objects): object /lib/modules/2.4.18/kernel/sound/acore/snd-pcm.o for module snd-pcm has changed since load
Warning (expand_objects): object /lib/modules/2.4.18/kernel/sound/acore/seq/oss/snd-seq-oss.o for module snd-seq-oss has changed since load
Warning (expand_objects): object /lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq-midi-event.o for module snd-seq-midi-event has changed since load
Warning (expand_objects): object /lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq.o for module snd-seq has changed since load
Warning (expand_objects): object /lib/modules/2.4.18/kernel/sound/acore/snd-timer.o for module snd-timer has changed since load
Warning (expand_objects): object /lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq-device.o for module snd-seq-device has changed since load
Warning (expand_objects): object /lib/modules/2.4.18/kernel/sound/acore/oss/snd-mixer-oss.o for module snd-mixer-oss has changed since load
Warning (expand_objects): object /lib/modules/2.4.18/kernel/sound/acore/snd.o for module snd has changed since load
Warning (compare_ksyms_lsmod): module sr_mod is in lsmod but not in ksyms, probably no symbols exported
Warning (compare_maps): ksyms_base symbol acpi_fadt_R__ver_acpi_fadt not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_gbl_FADT_R__ver_acpi_gbl_FADT not found in System.map.  Ignoring ksyms_base entry
Invalid operand: 0000
CPU:    0
EIP: 0010: [<c01565f0>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000000d ebx: d010d8e0 ecx: dd384000 edx: 00000001
esi: cd0d1a14 edi: c49a7d60 ebp: bfffe4cc esp: c1b7bf18
ds: 0018 es: 0018 ss: 0018
Process rmmod (pid: 24039, stackpage=c1b76000)
Stack: c0244807 c02447ea c02447e0 d010d8e0 d010d8e0 c01575d8 d010d8e0 d010d2e0
        d010d8e0 cd0d1a14 e090b362 d010d8e0 cd0d1a00 00000000 e0d5d3be cd0d1a14
        00000600 00000000 c49a7d60 d010dee0 e0d5ea80 c01c544a c49a7d60 e0d5c000
Call Trace: [<c01575d8>] [<e0d5d424>] [<e0d5d3be>] [<e0d5ea80>] [<c01c544a>] [<c01c555e>] [<e0d5ea80>] [<e0d5d424>] [<e0d5ea80>] [<c011980f>] [<c0118b12>]
        [<c0106e23>]
Code: 0f 0b 83 c4 10 f0 ff 4b 04 0f 94 c0 84 c0 0f 84 93 00 00 00 

>>EIP; c01565f0 <devfs_put+30/dc>   <=====
Trace; c01575d8 <devfs_unregister+30/38>
Trace; e0d5d424 <[usb-uhci]__module_license+9099/fcd5>
Trace; e0d5d3be <[usb-uhci]__module_license+9033/fcd5>
Trace; e0d5ea80 <[usb-uhci]__module_license+a6f5/fcd5>
Trace; c01c544a <scsi_unregister_device+52/d4>
Trace; c01c555e <scsi_unregister_module+36/3c>
Trace; e0d5ea80 <[usb-uhci]__module_license+a6f5/fcd5>
Trace; e0d5d424 <[usb-uhci]__module_license+9099/fcd5>
Trace; e0d5ea80 <[usb-uhci]__module_license+a6f5/fcd5>
Trace; c011980f <free_module+17/b4>
Trace; c0118b12 <sys_delete_module+126/234>
Trace; c0106e23 <system_call+33/38>
Code;  c01565f0 <devfs_put+30/dc>
00000000 <_EIP>:
Code;  c01565f0 <devfs_put+30/dc>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01565f2 <devfs_put+32/dc>
   2:   83 c4 10                  add    $0x10,%esp
Code;  c01565f5 <devfs_put+35/dc>
   5:   f0 ff 4b 04               lock decl 0x4(%ebx)
Code;  c01565f9 <devfs_put+39/dc>
   9:   0f 94 c0                  sete   %al
Code;  c01565fc <devfs_put+3c/dc>
   c:   84 c0                     test   %al,%al
Code;  c01565fe <devfs_put+3e/dc>
   e:   0f 84 93 00 00 00         je     a7 <_EIP+0xa7> c0156697 <devfs_put+d7/dc>


13 warnings issued.  Results may not be reliable.

--------------6B43C47FD26D40E1CBB2C618--

