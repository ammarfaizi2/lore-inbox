Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUJNVJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUJNVJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUJNVIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 17:08:37 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:2472 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266864AbUJNVGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:06:14 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Date: Thu, 14 Oct 2004 17:06:06 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc4-mm1 oops on java
Message-ID: <20041014210606.GA23179@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

when i try to start jboss 4.0.0 (sun jdk 1.5.0), i get this oops.
trying to start the simple shutdown program does the same thing.

otherwise, it's debian unstable, 1.4Ghz pentium m, thinkpad r40.

Unable to handle kernel paging request at virtual address 00013c1c
 printing eip:
c011cdc4
*pde =3D 00000000
Oops: 0002 [#1]
PREEMPT=20
Modules linked in: ipv6 thermal fan button ac battery snd_intel8x0 snd_ac97=
_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_a=
lloc cpufreq_userspace cpufreq_powersave speedstep_centrino processor ide_c=
d cdrom evdev psmouse autofs4 af_packet ntfs agpgart e100 mii ds yenta_sock=
et pcmcia_core rtc
CPU:    0
EIP:    0060:[<c011cdc4>]    Not tainted VLI
EFLAGS: 00010082   (2.6.9-rc4-mm1)=20
EIP is at profile_hit+0x24/0x28
eax: 00000000   ebx: 000009c9   ecx: 00000000   edx: 00013c1c
esi: 00000000   edi: ffffffea   ebp: df2c8f94   esp: df2c8f94
ds: 007b   es: 007b   ss: 0068
Process java (pid: 2505, threadinfo=3Ddf2c8000 task=3Ddf15e510)
Stack: df2c8fbc c0118a9b df15e510 c03bd3e0 00000000 00000082 0000000a 00000=
9c9=20
       00000001 aa170bb0 df2c8000 c010512f 000009c9 00000000 aa170a20 00000=
001=20
       aa170bb0 aa170a20 0000009c 0000007b 0000007b 0000009c b7f50504 00000=
073=20
Call Trace:
 [<c0105f1a>] show_stack+0x7a/0x90
 [<c0106099>] show_registers+0x149/0x1b0
 [<c010628d>] die+0xdd/0x180
 [<c01169f1>] do_page_fault+0x2f1/0x60b
 [<c0105b7d>] error_code+0x2d/0x38
 [<c0118a9b>] setscheduler+0xab/0x230
 [<c010512f>] syscall_call+0x7/0xb
Code: ec 5d c3 8d 74 26 00 55 8b 0d 6c e6 3d c0 81 ea 28 02 10 c0 a1 68 e6 =
3d c0 89 e5 d3 ea 48 39 d0 0f 46 d0 a1 64 e6 3d c0 8d 14 90 <ff> 02 5d c3 5=
1 52 e8 11 94 1a 00 5a 59 e9 ef f9 ff ff 66 4a 0f=20
 <6>note: java[2505] exited with preempt_count 2
Unable to handle kernel paging request at virtual address 00013c1c
 printing eip:
c011cdc4
*pde =3D 00000000
Oops: 0002 [#2]
PREEMPT=20
Modules linked in: ipv6 thermal fan button ac battery snd_intel8x0 snd_ac97=
_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_a=
lloc cpufreq_userspace cpufreq_powersave speedstep_centrino processor ide_c=
d cdrom evdev psmouse autofs4 af_packet ntfs agpgart e100 mii ds yenta_sock=
et pcmcia_core rtc
CPU:    0
EIP:    0060:[<c011cdc4>]    Not tainted VLI
EFLAGS: 00010082   (2.6.9-rc4-mm1)=20
EIP is at profile_hit+0x24/0x28
eax: 00000000   ebx: 000009b0   ecx: 00000000   edx: 00013c1c
esi: 00000000   edi: ffffffea   ebp: df311f94   esp: df311f94
ds: 007b   es: 007b   ss: 0068
Process java (pid: 2480, threadinfo=3Ddf311000 task=3Ddf7e25d0)
Stack: df311fbc c0118a9b df7e25d0 c03bd3e0 df311fbc 00000082 00000005 00000=
9b0=20
       00000001 b7e88080 df311000 c010512f 000009b0 00000000 bfffd5a8 00000=
001=20
       b7e88080 bfffd5a8 0000009c 0000007b 0000007b 0000009c b7f50504 00000=
073=20
Call Trace:
 [<c0105f1a>] show_stack+0x7a/0x90
 [<c0106099>] show_registers+0x149/0x1b0
 [<c010628d>] die+0xdd/0x180
 [<c01169f1>] do_page_fault+0x2f1/0x60b
 [<c0105b7d>] error_code+0x2d/0x38
 [<c0118a9b>] setscheduler+0xab/0x230
 [<c010512f>] syscall_call+0x7/0xb
Code: ec 5d c3 8d 74 26 00 55 8b 0d 6c e6 3d c0 81 ea 28 02 10 c0 a1 68 e6 =
3d c0 89 e5 d3 ea 48 39 d0 0f 46 d0 a1 64 e6 3d c0 8d 14 90 <ff> 02 5d c3 5=
1 52 e8 11 94 1a 00 5a 59 e9 ef f9 ff ff 66 4a 0f=20
 <6>note: java[2480] exited with preempt_count 2
scheduling while atomic: java/0x04000002/2480
 [<c0105f47>] dump_stack+0x17/0x20
 [<c02c584f>] schedule+0x51f/0x530
 [<c02c5d70>] cond_resched+0x30/0x50
 [<c0149d03>] unmap_vmas+0x1a3/0x200
 [<c014e2c4>] exit_mmap+0x74/0x160
 [<c0119955>] mmput+0x35/0xd0
 [<c011e4a2>] do_exit+0x152/0x450
 [<c0106322>] die+0x172/0x180
 [<c01169f1>] do_page_fault+0x2f1/0x60b
 [<c0105b7d>] error_code+0x2d/0x38
 [<c0118a9b>] setscheduler+0xab/0x230
 [<c010512f>] syscall_call+0x7/0xb
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBbuo+CGPRljI8080RAinAAKCTMFHkR6O29kveGoaLU8kIePvj/ACgg2uS
IVJjIKpWXSIyBopV9mJSHK4=
=5JF4
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
