Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVAFUfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVAFUfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbVAFUcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:32:16 -0500
Received: from smtp.ono.com ([62.42.230.12]:31545 "EHLO resmta05.ono.com")
	by vger.kernel.org with ESMTP id S263033AbVAFUaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:30:30 -0500
Message-ID: <41DD9FD3.4060707@usuarios.retecal.es>
Date: Thu, 06 Jan 2005 21:30:11 +0100
From: =?ISO-8859-15?Q?Ram=F3n_Rey_Vicente?= <rrey@usuarios.retecal.es>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041218)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2
References: <20050106002240.00ac4611.akpm@osdl.org>
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

I get this ...

Unable to handle kernel NULL pointer dereference at virtual address 00000004
~ printing eip:
c01c8e83
*pde = 0bfc6067
*pte = 00000000
Oops: 0000 [#1]
Modules linked in: r128 iptable_nat ipt_state ip_conntrack
iptable_filter ip_tables 8139too mii crc32 snd_ens1371 snd_rawmidi
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd
snd_page_alloc gameport uhci_hcd via_agp floppy ide_cd cdrom
CPU:    0
EIP:    0060:[<c01c8e83>]    Not tainted VLI
EFLAGS: 00013246   (2.6.10-mm2)
EIP is at agp_bind_memory+0x43/0x80
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: cb0b0d20   edi: 00000000   ebp: 00000001   esp: cfb81f48
ds: 007b   es: 007b   ss: 0068
Process Xorg (pid: 4524, threadinfo=cfb81000 task=cd7215b0)
Stack: 00000000 cd4e2800 cc9f9440 c01d1f16 00000001 00000000 cd4e2800
00000036
~       c01d1ea0 c01cdf32 bffffb30 40086436 cd49d7e0 cbbd6e28 cd49d7e0
c01cde60
~       40086436 00000007 c01548d4 bffffb30 40086436 cd49d7e0 00000000
c0154a8a
Call Trace:
~ [<c01d1f16>] drm_agp_bind+0x76/0xc0
~ [<c01d1ea0>] drm_agp_bind+0x0/0xc0
~ [<c01cdf32>] drm_ioctl+0xd2/0x189
~ [<c01cde60>] drm_ioctl+0x0/0x189
~ [<c01548d4>] do_ioctl+0x34/0x60
~ [<c0154a8a>] sys_ioctl+0x6a/0x1c0
~ [<c01022d7>] syscall_call+0x7/0xb
Code: 29 00 74 24 8b 46 08 89 fa 8b 4e 20 8b 58 04 89 f0 ff 53 40 85 c0
75 0c c6 46 28 01 b8 00 00 00 00 89 7e 1c 5b 5e 5f c3 8b 46 08 <8b> 40
04 ff 50 34 c6 46 29 01 eb cd 56 68 40 30 27 c0 e8 66 99

- --
Ramón Rey Vicente <ramon.rey en hispalinux.es>
JID rreylinux@jabber.org - GPG public key id 0x9F28E377
GPG Fingerprint 0BC2 8014 2445 51E8 DE87  C888 C385 A9D3 9F28 E377
Planet AUGCyL - http://augcyl.org/planet/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB3Z/Rw4Wp058o43cRAuUiAJ4hpg0dZHVSbZT2bdp87zdwB27ZPACgxQHO
Rfo1bCjwIlMXd9P6yMhCdWY=
=sMmy
-----END PGP SIGNATURE-----
