Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbVIOSxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbVIOSxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 14:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030576AbVIOSxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 14:53:38 -0400
Received: from pop.gmx.net ([213.165.64.20]:59092 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030573AbVIOSxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 14:53:37 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-mm3 (general protection fault)
Date: Thu, 15 Sep 2005 20:58:07 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050912024350.60e89eb1.akpm@osdl.org>
In-Reply-To: <20050912024350.60e89eb1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1282683.oBxQDU3t5E";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509152058.13898.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1282683.oBxQDU3t5E
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 12 September 2005 11:43, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.=
13
>-mm3/

hi,
again a general protection fault...

usb 1-2.3: USB disconnect, address 5
general protection fault: 0000 [1] PREEMPT SMP
CPU 0
Modules linked in: nls_cp437 vfat fat ppp_deflate bsd_comp ppp_async r8169=
=20
snd_bt87x
Pid: 84, comm: khubd Tainted: P      2.6.13-mm3 #12
RIP: 0010:[<ffffffff8035a005>] <ffffffff8035a005>{scsi_remove_device+53}
RSP: 0000:ffff81003f811bc8  EFLAGS: 00010246
RAX: 6b6b6b6b6b6b6b6b RBX: ffff810000902458 RCX: 0000000000000034
RDX: 0000000000000001 RSI: ffffffff80267170 RDI: 6b6b6b6b6b6b6beb
RBP: ffff81003f811bd8 R08: 0000000000000000 R09: ffff810000902458
R10: 0000000000000000 R11: 0000000000000000 R12: ffff81002dce50f8
R13: ffff8100125ca0f8 R14: ffff81002dce5108 R15: 0000000000000003
=46S:  00002aaaaadfdb00(0000) GS:ffffffff806ed800(0000) knlGS:0000000056114=
840
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaac56480 CR3: 0000000000101000 CR4: 00000000000006e0
Process khubd (pid: 84, threadinfo ffff81003f810000, task ffff81003fc8cea0)
Stack: 0000000000000213 ffff810000902458 ffff81003f811c08 ffffffff8035a364
ffff81002dce5110 ffff8100125ca120 ffff81002dce5110 ffff81002dce5118
ffff81003f811c28 ffffffff8035a3f7
Call Trace:<ffffffff8035a364>{__scsi_remove_target+148}=20
<ffffffff8035a3f7>{scsi_remove_target+39}
<ffffffff8035916b>{scsi_forget_host+75}=20
<ffffffff80351c9d>{scsi_remove_host+77}
<ffffffff803a20ac>{quiesce_and_remove_host+156}=20
<ffffffff803a2bd8>{storage_disconnect+24}
<ffffffff80380f35>{usb_unbind_interface+85}=20
<ffffffff802e32f1>{__device_release_driver+113}
<ffffffff802e3355>{device_release_driver+53}=20
<ffffffff802e2a7c>{bus_remove_device+172}
<ffffffff802e19f8>{device_del+56} <ffffffff80388b32>{usb_disable_device+178}
<ffffffff8038349e>{usb_disconnect+190} <ffffffff80384a42>{hub_thread+930}
<ffffffff8046ac8f>{thread_return+203}=20
<ffffffff8014bf80>{autoremove_wake_function+0}
<ffffffff8014bf80>{autoremove_wake_function+0}=20
<ffffffff803846a0>{hub_thread+0}
<ffffffff8014b86b>{kthread+219} <ffffffff8010ee06>{child_rip+8}
<ffffffff8014b790>{kthread+0} <ffffffff8010edfe>{child_rip+0}
Sep 15 18:55:18 dkey_amd64
Sep 15 18:55:18 dkey_amd64
Code: f0 ff 80 80 00 00 00 0f 8e 4e 07 00 00 48 83 c4 08 5b c9 c3
RIP <ffffffff8035a005>{scsi_remove_device+53} RSP <ffff81003f811bc8>


dominik

--nextPart1282683.oBxQDU3t5E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQynERQvcoSHvsHMnAQI9rQQAnf7HUlMBZE8sZw6TaDymOZuskwPl32n4
3O97exudpOd7YHAkooLE5pgk6Wi+gmPmAWYTOuUS2tcFm3lJrws70iDvXqMsd54J
C3nK2R77IMwhCh9kyMpjIRTREpgGnVmX/BIGfUWA1HIuhudLU+3OBYXurddyFYyG
6T7wY4EnphA=
=dCwB
-----END PGP SIGNATURE-----

--nextPart1282683.oBxQDU3t5E--
