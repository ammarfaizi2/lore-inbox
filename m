Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267584AbUHRTw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267584AbUHRTw2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 15:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267588AbUHRTw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 15:52:28 -0400
Received: from ctb-mesg1.saix.net ([196.25.240.73]:45457 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S267584AbUHRTwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 15:52:25 -0400
Subject: Re: [UPDATED PATCH 1/2] export module parameters in sysfs for
	modules _and_ built-in code
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Greg KH <greg@kroah.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040802214710.GB7772@dominikbrodowski.de>
References: <20040801165407.GA8667@dominikbrodowski.de>
	 <1091426395.430.13.camel@bach>  <20040802214710.GB7772@dominikbrodowski.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EvuW+lVxiTbc4Sy5kneY"
Message-Id: <1092858948.8998.47.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 18 Aug 2004 21:55:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EvuW+lVxiTbc4Sy5kneY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-08-02 at 23:47, Dominik Brodowski wrote:

I know its tainted (nvidia), but this is difficult to test,
as it usually only happens if the box have been up for a while
and I modprobe something (ext2 in most of the cases).

---
Unable to handle kernel paging request at virtual address 39cc6b10
 printing eip:
c03d16c4
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: e1000 snd_intel8x0 snd_ac97_codec gameport snd_mpu401_ua=
rt snd_rawmidi snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pc=
m_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd joydev nvidia usbh=
id uhci_hcd ehci_hcd usbcore w83781d i2c_sensor i2c_isa i2c_i801 i2c_dev i2=
c_core
CPU:    1
EIP:    0060:[<c03d16c4>]    Tainted: P
EFLAGS: 00010286   (2.6.8.1)
EIP is at param_sysfs_setup+0x0/0x129
eax: f9cb338c   ebx: 00000000   ecx: f7db4ec0   edx: c0333820
esi: f9cb3380   edi: f9cb33cc   ebp: f9b48000   esp: c9709ebc
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 17632, threadinfo=3Dc9708000 task=3De15a4670)
Stack: c01312f4 f9cb338c f9cb3380 00000000 00000000 00000000 f9cb33cc 00000=
000
       f9cb3380 00000000 c013644a f9cb3380 00000000 00000000 f9c90000 f9c9d=
0f4
       f9cb3380 c0137644 f9cb3380 00000000 00000000 00000000 00000000 f9cb3=
380
Call Trace:
 [<c01312f4>] module_param_sysfs_setup+0x41/0x95
 [<c013644a>] mod_sysfs_setup+0x89/0xb4
 [<c0137644>] load_module+0x916/0xbd9
 [<c013798a>] sys_init_module+0x83/0x25e
 [<c0104195>] sysenter_past_esp+0x52/0x71
Code: 65 6e 40 6e 6f 72 74 65 6c 6e 65 74 77 6f 72 6b 73 2e 63 6f
---

PS: If needed, I can try to get some time to leave it up not
    in X ...


Thanks,

--=20
Martin Schlemmer

--=-EvuW+lVxiTbc4Sy5kneY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBI7REqburzKaJYLYRAuDzAKCRkWWefiwuQnu3eBv3x3FSjOWyCQCfYUCF
WRPVTUZlAiWH+R2SPPqKdQo=
=l6wq
-----END PGP SIGNATURE-----

--=-EvuW+lVxiTbc4Sy5kneY--

