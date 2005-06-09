Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbVFIXqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVFIXqh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 19:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVFIXqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 19:46:36 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:3036 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262444AbVFIXq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 19:46:29 -0400
Subject: [OOPS] powernow on smp dual core amd64
From: Tom Duffy <tduffy@sun.com>
To: linux-kernel@vger.kernel.org
Cc: discuss@x86-64.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-n51BjsZbKiJ4VRws1FEx"
Date: Thu, 09 Jun 2005 16:46:19 -0700
Message-Id: <1118360779.13654.4.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-n51BjsZbKiJ4VRws1FEx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Got this panic when I recently upgraded my BIOS so that it supports k8
powernow on SMP dual-core.

Unable to handle kernel NULL pointer dereference at 0000000000000024 RIP:
<ffffffff8011dadc>{query_current_values_with_pending_wait+60}
PGD 0
Oops: 0002 [1] SMP
CPU 1
Modules linked in: nls_utf8 e1000(U) parport_pc lp parport sr_mod autofs4 m=
d5 ipv6 sunrpc usb_storage pcmcia yenta_socket rsrc_nonstatic pcmcia_core x=
fs exportfs video button battery ac ohci_hcd ehci_hcd i2c_nforce2 i2c_core =
shpchp usbnet mii dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod sata_nv lib=
ata qla2322 qla2xxx scsi_transport_fc mptscsih(U) mptbase(U) sd_mod scsi_mo=
d
Pid: 26, comm: events/0 Not tainted 2.6.11-1.1369_FC4smp
RIP: 0010:[<ffffffff8011dadc>] <ffffffff8011dadc>{query_current_values_with=
_pending_wait+60}
RSP: 0000:ffff81003fca3dc8  EFLAGS: 00010202
RAX: 000000000000000e RBX: 0000000000000000 RCX: 00000000c0010042
RDX: 0000000000000008 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff81003fca2000 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000292 R15: ffffffff80112950
FS:  00002aaaaadfd6e0(0000) GS:ffffffff80510700(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000024 CR3: 000000003e8c8000 CR4: 00000000000006e0
Process events/0 (pid: 26, threadinfo ffff81003fca2000, task ffff81007fd9b8=
40)
Stack: 0000000000000000 ffffffff8011e0b1 0000000000000001 ffff81003feb1e00
       ffff81003feb1e30 ffffffff802e7d03 0000000000000000 0000000000000003
       0000000000000001 0000000000000020
Call Trace:<ffffffff8011e0b1>{powernowk8_get+129} <ffffffff802e7d03>{cpufre=
q_get+115}
       <ffffffff8011298a>{handle_cpufreq_delayed_get+58} <ffffffff8014b9dc>=
{worker_thread+476}
       <ffffffff80134710>{default_wake_function+0}

--=-n51BjsZbKiJ4VRws1FEx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCqNTLdY502zjzwbwRAuA8AJ43S1Z5Q0QpPVwR7WIS/z+dDJNMUACfYIXA
puqF5BQPS7GQISW5nDpB8BM=
=BCD9
-----END PGP SIGNATURE-----

--=-n51BjsZbKiJ4VRws1FEx--
