Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWE3LBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWE3LBe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 07:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWE3LBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 07:01:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:27295 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932165AbWE3LBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 07:01:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=GQp8KFa0MTBErMam3fJAVzDZQuz1Yj81igD/f0AzHhjat+nwV8rBKm8N+x8gV72HEaEuWDL7zZoksmcqLb7O5VSzioK2sGyADpvlFJwYlMJt53lhCSG1NeD3b3KyJGTXHjLla7hmiT17T1u08X+njB4/72x07EA6P++XTLp46Cg=
Message-ID: <447C261E.1090202@gmail.com>
Date: Tue, 30 May 2006 13:01:27 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@vger.kernel.org,
       kuznet@ms2.inr.ac.ru, alan@redhat.com
Subject: BUG: warning at ... (netlink) [Was: 2.6.17-rc5-mm1]
References: <20060530022925.8a67b613.akpm@osdl.org>
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton napsal(a):
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/

BUG: warning at /l/latest/xxx/kernel/softirq.c:86/local_bh_disable()
 [<c0103e66>] show_trace+0x1b/0x1d
 [<c01045a4>] dump_stack+0x26/0x28
 [<c012708f>] local_bh_disable+0x53/0x55
 [<c0399fd6>] _write_lock_bh+0x10/0x15
 [<c034e314>] netlink_table_grab+0x12/0xe9
 [<c034e6f6>] netlink_insert+0x2a/0x156
 [<c034fa46>] netlink_kernel_create+0xad/0x143
 [<c051f869>] rtnetlink_init+0x70/0xc7
 [<c051fb9f>] netlink_proto_init+0x187/0x192
 [<c01003cb>] init+0x12b/0x2f1
 [<c0101005>] kernel_thread_helper+0x5/0xb

If more info needed, feel free to ask.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEfCYeMsxVwznUen4RApvNAJ94piY4mvFzO9x3qSBKL8DstkeBbgCguCnz
Zzw1YFf/s3AtKVo0XgYWsek=
=x+hX
-----END PGP SIGNATURE-----
