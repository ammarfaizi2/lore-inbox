Return-Path: <linux-kernel-owner+w=401wt.eu-S1754562AbWLYW4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562AbWLYW4T (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 17:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754573AbWLYW4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 17:56:19 -0500
Received: from iucha.net ([209.98.146.184]:42315 "EHLO mail.iucha.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754562AbWLYW4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 17:56:18 -0500
X-Greylist: delayed 928 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Dec 2006 17:56:17 EST
Date: Mon, 25 Dec 2006 16:56:16 -0600
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc2
Message-ID: <20061225225616.GA22307@iucha.net>
References: <20061225224047.GB6087@iucha.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <20061225224047.GB6087@iucha.net>
X-GPG-Key: http://iucha.net/florin_iucha.gpg
X-GPG-Fingerprint: 5E59 C2E7 941E B592 3BA4  7DCF 343D 2B14 2376 6F5B
User-Agent: Mutt/1.5.13 (2006-08-11)
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: multipart/mixed; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The dmesg from the client machine is attached.

Now, really.

BTW, I am using NFSv4 exported async from the server and mounted
without any extra options on the client.

florin

--=20
Bruce Schneier expects the Spanish Inquisition.
      http://geekz.co.uk/schneierfacts/fact/163

--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=the_oops
Content-Transfer-Encoding: quoted-printable

[ 2844.871895] BUG: scheduling while atomic: cp/0x20000000/2965
[ 2844.871900]=20
[ 2844.871901] Call Trace:
[ 2844.871910]  [<ffffffff8015b97d>] __sched_text_start+0x5d/0x7a6
[ 2844.871914]  [<ffffffff8012f6b0>] submit_bio+0x84/0x8b
[ 2844.871918]  [<ffffffff801f8ea6>] ext3_get_block+0x0/0xe4
[ 2844.871922]  [<ffffffff80112933>] __pagevec_lru_add+0xb6/0xc6
[ 2844.871927]  [<ffffffff801c02f0>] mpage_bio_submit+0x22/0x26
[ 2844.871931]  [<ffffffff8012cb30>] unix_poll+0x0/0xa4
[ 2844.871936]  [<ffffffff8017d801>] __cond_resched+0x1c/0x44
[ 2844.871940]  [<ffffffff8015c1d0>] cond_resched+0x29/0x30
[ 2844.871943]  [<ffffffff8015dd92>] __reacquire_kernel_lock+0x26/0x44
[ 2844.871948]  [<ffffffff8015c169>] thread_return+0xa3/0xe1
[ 2844.871953]  [<ffffffff80116664>] unlock_page+0x9/0x26
[ 2844.871957]  [<ffffffff8017d801>] __cond_resched+0x1c/0x44
[ 2844.871961]  [<ffffffff8015c1d0>] cond_resched+0x29/0x30
[ 2844.871965]  [<ffffffff8019e8b6>] generic_writepages+0x113/0x2d8
[ 2844.871970]  [<ffffffff8022771c>] nfs_writepage+0x0/0x22
[ 2844.871976]  [<ffffffff802280ff>] nfs_writepages+0x45/0x13c
[ 2844.871980]  [<ffffffff801536e6>] do_writepages+0x20/0x2d
[ 2844.871984]  [<ffffffff801487be>] __filemap_fdatawrite_range+0x51/0x5b
[ 2844.871989]  [<ffffffff8019ca9b>] filemap_write_and_wait+0x17/0x31
[ 2844.871993]  [<ffffffff80220948>] nfs_setattr+0x98/0x108
[ 2844.871996]  [<ffffffff80129c6e>] mntput_no_expire+0x19/0x7b
[ 2844.872000]  [<ffffffff8010dab9>] link_path_walk+0xc5/0xd7
[ 2844.872005]  [<ffffffff8010d340>] current_fs_time+0x3b/0x40
[ 2844.872009]  [<ffffffff80129b48>] notify_change+0x122/0x22f
[ 2844.872014]  [<ffffffff801bb806>] do_utimes+0x106/0x129
[ 2844.872019]  [<ffffffff8010ac5b>] vfs_read+0xaa/0x152
[ 2844.872023]  [<ffffffff801bb865>] sys_futimesat+0x3c/0x4b
[ 2844.872027]  [<ffffffff8015671e>] system_call+0x7e/0x83
[ 2844.872030]=20
[ 3606.114991] [drm] Loading R300 Microcode
[ 3878.479521] BUG: scheduling while atomic: cp/0x20000000/3129
[ 3878.479526]=20
[ 3878.479527] Call Trace:
[ 3878.479536]  [<ffffffff8015b97d>] __sched_text_start+0x5d/0x7a6
[ 3878.479541]  [<ffffffff8015dae8>] __down+0xbe/0x100
[ 3878.479546]  [<ffffffff8017d3a4>] default_wake_function+0x0/0xe
[ 3878.479571]  [<ffffffff803f4f25>] unx_validate+0x0/0x56
[ 3878.479575]  [<ffffffff8017d801>] __cond_resched+0x1c/0x44
[ 3878.479579]  [<ffffffff8015c1d0>] cond_resched+0x29/0x30
[ 3878.479583]  [<ffffffff8015dd92>] __reacquire_kernel_lock+0x26/0x44
[ 3878.479587]  [<ffffffff8015c169>] thread_return+0xa3/0xe1
[ 3878.479591]  [<ffffffff8015c169>] thread_return+0xa3/0xe1
[ 3878.479595]  [<ffffffff80155950>] cache_alloc_refill+0x63/0x4ac
[ 3878.479600]  [<ffffffff8017d801>] __cond_resched+0x1c/0x44
[ 3878.479606]  [<ffffffff8015c1d0>] cond_resched+0x29/0x30
[ 3878.479609]  [<ffffffff80109c06>] kmem_cache_alloc+0x14/0x54
[ 3878.479613]  [<ffffffff802233c2>] nfs_create_request+0x3d/0x109
[ 3878.479618]  [<ffffffff802273ee>] nfs_writepage_setup+0x1ab/0x3b5
[ 3878.479624]  [<ffffffff80227a6b>] nfs_updatepage+0xf5/0x134
[ 3878.479628]  [<ffffffff8021e307>] nfs_commit_write+0x2e/0x41
[ 3878.479758]  [<ffffffff8010f1be>] generic_file_buffered_write+0x482/0x690
[ 3878.479764]  [<ffffffff8015b3f7>] copy_user_generic_string+0x17/0x40
[ 3878.479770]  [<ffffffff80114fb5>] __generic_file_aio_write_nolock+0x379/=
0x3ec
[ 3878.479775]  [<ffffffff8011f7be>] generic_file_aio_write+0x61/0xc1
[ 3878.479780]  [<ffffffff8021e822>] nfs_file_write+0xb4/0x121
[ 3878.479784]  [<ffffffff80116618>] do_sync_write+0xc9/0x10c
[ 3878.479790]  [<ffffffff8018e2ea>] autoremove_wake_function+0x0/0x2e
[ 3878.479794]  [<ffffffff8015c0c6>] thread_return+0x0/0xe1
[ 3878.479799]  [<ffffffff8011534a>] vfs_write+0xad/0x156
[ 3878.479802]  [<ffffffff80115cbe>] sys_write+0x45/0x6e
[ 3878.479807]  [<ffffffff8015671e>] system_call+0x7e/0x83
[ 3878.479810]=20
[ 4280.656585] BUG: scheduling while atomic: cp/0x20000000/3129
[ 4280.656590]=20
[ 4280.656591] Call Trace:
[ 4280.656600]  [<ffffffff8015b97d>] __sched_text_start+0x5d/0x7a6
[ 4280.656605]  [<ffffffff8010e513>] __alloc_pages+0x61/0x2a8
[ 4280.656609]  [<ffffffff801f8ea6>] ext3_get_block+0x0/0xe4
[ 4280.656612]  [<ffffffff80112933>] __pagevec_lru_add+0xb6/0xc6
[ 4280.656617]  [<ffffffff8012cb30>] unix_poll+0x0/0xa4
[ 4280.656622]  [<ffffffff8017d801>] __cond_resched+0x1c/0x44
[ 4280.656626]  [<ffffffff8015c1d0>] cond_resched+0x29/0x30
[ 4280.656629]  [<ffffffff8015dd92>] __reacquire_kernel_lock+0x26/0x44
[ 4280.656634]  [<ffffffff8015c169>] thread_return+0xa3/0xe1
[ 4280.656638]  [<ffffffff8022308f>] nfs_unlock_request+0x1/0x37
[ 4280.656644]  [<ffffffff8017d801>] __cond_resched+0x1c/0x44
[ 4280.656647]  [<ffffffff8015c1d0>] cond_resched+0x29/0x30
[ 4280.656652]  [<ffffffff8019e8b6>] generic_writepages+0x113/0x2d8
[ 4280.656656]  [<ffffffff8022771c>] nfs_writepage+0x0/0x22
[ 4280.656662]  [<ffffffff802280ff>] nfs_writepages+0x45/0x13c
[ 4280.656677]  [<ffffffff801536e6>] do_writepages+0x20/0x2d
[ 4280.656681]  [<ffffffff801487be>] __filemap_fdatawrite_range+0x51/0x5b
[ 4280.656686]  [<ffffffff8019ca9b>] filemap_write_and_wait+0x17/0x31
[ 4280.656690]  [<ffffffff80220948>] nfs_setattr+0x98/0x108
[ 4280.656693]  [<ffffffff80129c6e>] mntput_no_expire+0x19/0x7b
[ 4280.656697]  [<ffffffff8010dab9>] link_path_walk+0xc5/0xd7
[ 4280.656702]  [<ffffffff8010d340>] current_fs_time+0x3b/0x40
[ 4280.656706]  [<ffffffff80129b48>] notify_change+0x122/0x22f
[ 4280.656710]  [<ffffffff801bb806>] do_utimes+0x106/0x129
[ 4280.656715]  [<ffffffff8015c0c6>] thread_return+0x0/0xe1
[ 4280.656719]  [<ffffffff8010ac5b>] vfs_read+0xaa/0x152
[ 4280.656723]  [<ffffffff80115ca6>] sys_write+0x2d/0x6e
[ 4280.656727]  [<ffffffff801bb865>] sys_futimesat+0x3c/0x4b
[ 4280.656731]  [<ffffffff8015671e>] system_call+0x7e/0x83
[ 4280.656734]=20
[ 4811.737194] [drm] Loading R300 Microcode
[ 5355.331624] BUG: scheduling while atomic: hald-addon-stor/0x20000000/2066
[ 5355.331630]=20
[ 5355.331631] Call Trace:
[ 5355.331641]  [<ffffffff8015b97d>] __sched_text_start+0x5d/0x7a6
[ 5355.331646]  [<ffffffff8017b7bf>] task_rq_lock+0x3d/0x6f
[ 5355.331650]  [<ffffffff8017b4fa>] __activate_task+0x27/0x39
[ 5355.331655]  [<ffffffff80140d26>] try_to_wake_up+0x363/0x374
[ 5355.331660]  [<ffffffff8017d801>] __cond_resched+0x1c/0x44
[ 5355.331677]  [<ffffffff8015c1d0>] cond_resched+0x29/0x30
[ 5355.331681]  [<ffffffff8015dd92>] __reacquire_kernel_lock+0x26/0x44
[ 5355.331713]  [<ffffffff8015c169>] thread_return+0xa3/0xe1
[ 5355.331748]  [<ffffffff8017d801>] __cond_resched+0x1c/0x44
[ 5355.331753]  [<ffffffff8015c1d0>] cond_resched+0x29/0x30
[ 5355.331756]  [<ffffffff8015c206>] wait_for_completion+0x17/0xc6
[ 5355.331761]  [<ffffffff8027e778>] blk_execute_rq_nowait+0x7a/0x8e
[ 5355.331764]  [<ffffffff8027e824>] blk_execute_rq+0x98/0xb8
[ 5355.331768]  [<ffffffff8012690b>] get_request_wait+0x2a/0x10c
[ 5355.331772]  [<ffffffff8010c5d4>] dput+0x2b/0x15a
[ 5355.331859]  [<ffffffff8030f236>] scsi_execute+0xd4/0xf1
[ 5355.331863]  [<ffffffff8030f30c>] scsi_execute_req+0xb9/0xde
[ 5355.331868]  [<ffffffff8030f36a>] scsi_test_unit_ready+0x39/0x7b
[ 5355.331872]  [<ffffffff80280417>] get_disk+0x40/0x5b
[ 5355.331876]  [<ffffffff80314592>] sd_media_changed+0x40/0x8d
[ 5355.331881]  [<ffffffff801bde51>] check_disk_change+0x1f/0x76
[ 5355.331884]  [<ffffffff80314343>] sd_open+0x80/0x113
[ 5355.331888]  [<ffffffff801be4af>] do_open+0x9f/0x2ae
[ 5355.331892]  [<ffffffff80111137>] may_open+0x5b/0x1bd
[ 5355.331908]  [<ffffffff801be881>] blkdev_open+0x0/0x5d
[ 5355.331911]  [<ffffffff801be8af>] blkdev_open+0x2e/0x5d
[ 5355.331916]  [<ffffffff8011cbd1>] __dentry_open+0xd9/0x1a7
[ 5355.331920]  [<ffffffff8012526d>] do_filp_open+0x2d/0x3d
[ 5355.331923]  [<ffffffff8015ce0f>] do_nanosleep+0x47/0x70
[ 5355.331928]  [<ffffffff801327b4>] __strncpy_from_user+0x17/0x41
[ 5355.331933]  [<ffffffff80118302>] do_sys_open+0x44/0xc8
[ 5355.331937]  [<ffffffff8015671e>] system_call+0x7e/0x83
[ 5355.331940]=20
[ 5692.153923] BUG: scheduling while atomic: hald-addon-stor/0x20000000/2066
[ 5692.153930]=20
[ 5692.153932] Call Trace:
[ 5692.153939]  [<ffffffff80140d26>] try_to_wake_up+0x363/0x374
[ 5692.153944]  [<ffffffff8015b97d>] __sched_text_start+0x5d/0x7a6
[ 5692.153951]  [<ffffffff8017b7bf>] task_rq_lock+0x3d/0x6f
[ 5692.153954]  [<ffffffff8017b4fa>] __activate_task+0x27/0x39
[ 5692.153959]  [<ffffffff80140d26>] try_to_wake_up+0x363/0x374
[ 5692.153964]  [<ffffffff8017d801>] __cond_resched+0x1c/0x44
[ 5692.153967]  [<ffffffff8015c1d0>] cond_resched+0x29/0x30
[ 5692.153971]  [<ffffffff8015dd92>] __reacquire_kernel_lock+0x26/0x44
[ 5692.154034]  [<ffffffff8015c169>] thread_return+0xa3/0xe1
[ 5692.154039]  [<ffffffff8017d801>] __cond_resched+0x1c/0x44
[ 5692.154043]  [<ffffffff8015c1d0>] cond_resched+0x29/0x30
[ 5692.154047]  [<ffffffff8015c206>] wait_for_completion+0x17/0xc6
[ 5692.154051]  [<ffffffff8027e778>] blk_execute_rq_nowait+0x7a/0x8e
[ 5692.154055]  [<ffffffff8027e824>] blk_execute_rq+0x98/0xb8
[ 5692.154059]  [<ffffffff8012690b>] get_request_wait+0x2a/0x10c
[ 5692.154065]  [<ffffffff8030f236>] scsi_execute+0xd4/0xf1
[ 5692.154069]  [<ffffffff8030f30c>] scsi_execute_req+0xb9/0xde
[ 5692.154150]  [<ffffffff80312e4f>] sd_revalidate_disk+0xea/0xcf1
[ 5692.154155]  [<ffffffff8030f36a>] scsi_test_unit_ready+0x39/0x7b
[ 5692.154159]  [<ffffffff801acb76>] get_super+0x1a/0x95
[ 5692.154164]  [<ffffffff801bde81>] check_disk_change+0x4f/0x76
[ 5692.154167]  [<ffffffff80314343>] sd_open+0x80/0x113
[ 5692.154171]  [<ffffffff801be4af>] do_open+0x9f/0x2ae
[ 5692.154175]  [<ffffffff80111137>] may_open+0x5b/0x1bd
[ 5692.154179]  [<ffffffff801be881>] blkdev_open+0x0/0x5d
[ 5692.154182]  [<ffffffff801be8af>] blkdev_open+0x2e/0x5d
[ 5692.154187]  [<ffffffff8011cbd1>] __dentry_open+0xd9/0x1a7
[ 5692.154190]  [<ffffffff8012526d>] do_filp_open+0x2d/0x3d
[ 5692.154194]  [<ffffffff8015ce0f>] do_nanosleep+0x47/0x70
[ 5692.154202]  [<ffffffff801327b4>] __strncpy_from_user+0x17/0x41
[ 5692.154207]  [<ffffffff80118302>] do_sys_open+0x44/0xc8
[ 5692.154211]  [<ffffffff8015671e>] system_call+0x7e/0x83
[ 5692.154214]=20

--TakKZr9L6Hm6aLOc--

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFkFcQND0rFCN2b1sRAv6IAJ0X4MgY/lbfMrOplanek+co7ahOHgCdGYB7
/zkBj0ZFzoMECQfPTaZXsf8=
=pnVT
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
