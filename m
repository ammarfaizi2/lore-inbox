Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbTIFSov (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 14:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbTIFSov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 14:44:51 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:24763 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261325AbTIFSor convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 14:44:47 -0400
From: "Max O'Shea" <maxo@myrealbox.com>
Reply-To: maxo@myrealbox.com
To: linux-kernel@vger.kernel.org
Subject: bug/request: multi-processing for CD devices
Date: Sat, 6 Sep 2003 19:45:26 +0000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200309061945.30402.maxo@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I don't know if this would be considered a 'bug', maybe more of a feature 
request?

Summary: request for multi-processing for CD devices (I think the word is 
'multi-processing' - ie. so that you can play an audio CD and browse the 
audio CD using a program such as konqueror at the same time)

Full description: At the moment, if you are playing an audio CD with one 
program and you start accessing the audio CD with another program, the music 
will stop playing.

Keywords: audio, sound, /dev/hdc , /dev/ide0, alsa, oss

Here's a little bit of system information if it helps:

Kernel Version: Linux version 2.4.21-0.13mdkcustom (root@tuxmachine) (gcc 
version 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk)) #1 Sat Jul 5 12:27:17 BST 2003

- --------------------------------------
Processor information: processor
: 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 498.495
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 992.87

- --------------------------------------
Module information:

ppp_deflate             4536   0 (autoclean)
zlib_inflate           21348   0 (autoclean) [ppp_deflate]
zlib_deflate           21624   0 (autoclean) [ppp_deflate]
bsd_comp                5336   0 (autoclean)
binfmt_misc             7404   1
ide-cd                 35776   1 (autoclean)
parport_pc             27208   1 (autoclean)
lp                      8480   0 (autoclean)
parport                36960   1 (autoclean) [parport_pc lp]
i810                   65440  23
agpgart                43680   7 (autoclean)
es1371                 30472   0
soundcore               6628   0 [es1371]
ac97_codec             13576   0 [es1371]
gameport                3412   0 [es1371]
ppp_async               9408   1
ppp_generic            24636   3 [ppp_deflate bsd_comp ppp_async]
slhc                    6628   0 [ppp_generic]
af_packet              15528   0 (autoclean)
floppy                 57148   0
eepro100               22836   1 (autoclean)
mii                     3992   0 (autoclean) [eepro100]
nls_iso8859-15          4092   1 (autoclean)
nls_cp850               4316   1 (autoclean)
vfat                   12780   1 (autoclean)
fat                    39224   0 (autoclean) [vfat]
supermount             16480   3 (autoclean)
sr_mod                 17976   0
cdrom                  33920   0 [ide-cd sr_mod]
scsimon                 9824   0 (unused)
usb-storage            78648   0
scsi_mod              106548   3 [sr_mod scsimon usb-storage]
usb-uhci               26220   0 (unused)
usbcore                77760   1 [usb-storage usb-uhci]
rtc                     8412   0 (autoclean)
ext3                   59916   2
jbd                    38972   2 [ext3]

- --------------------------------------
Output of /proc/devices :

Character devices:
  1 mem
  2 pty/m%d
  3 pty/s%d
  4 tts/%d
  5 cua/%d
  6 lp
  7 vcs
 10 misc
 14 sound
 29 fb
108 ppp
128 ptm
136 pts/%d
162 raw
180 usb
226 drm

Block devices:
  1 ramdisk
  2 fd
  3 ide0
  9 md
 11 sr
 22 ide1

- --------------------------------------

Output of /proc/mounts :

rootfs / rootfs rw 0 0
/dev/root / ext3 rw 0 0
none /dev devfs rw 0 0
none /proc proc rw 0 0
none /proc/bus/usb usbdevfs rw 0 0
none /dev/pts devpts rw 0 0
/dev/hda7 /home ext3 rw 0 0
none /mnt/cdrom supermount ro 0 0
none /mnt/cdrw supermount ro 0 0
none /mnt/floppy supermount rw,sync 0 0
/dev/hda1 /mnt/windows vfat rw 0 0
none /proc/sys/fs/binfmt_misc binfmt_misc rw 0 0


I am not subscribed to the linux-kernel list (well, I was, but after I had to 
delete 100000 messages and my email account was ready to be closed, I had to 
unsubscribe) so if you could possibly cc: me if you can be bothered to or if 
you really need to.

Many thanks :-)

- --Max.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/WjlZJs1Ztj8KHd8RAmkdAJ9EW18dsWBnRdvGhH/k77nHVosmegCgt64d
ob5EEFx65Wo27awaRIGJTM8=
=UPe9
-----END PGP SIGNATURE-----

