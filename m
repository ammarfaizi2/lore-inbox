Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbTLRUNV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 15:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265321AbTLRUNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 15:13:20 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:60293
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S265317AbTLRUNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 15:13:19 -0500
Message-ID: <3FE209E9.6000200@redhat.com>
Date: Thu, 18 Dec 2003 12:11:21 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeremy Kusnetz <JKusnetz@nrtc.org>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 is freezing my systems hard after 24-48 hours
References: <F7F4B5EA9EBD414D8A0091E80389450569D3F6@exchange.nrtc.coop>
In-Reply-To: <F7F4B5EA9EBD414D8A0091E80389450569D3F6@exchange.nrtc.coop>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeremy Kusnetz wrote:

> BUG IN DYNAMIC LINKER ld.so: ../sysdeps/i386/dl-machine.h: 391: elf_machine_lazy_rel: Assertion `((reloc->r_info) & 0xff) == 7' failed!

If your system is healthy, you'll see this message for every binary
(i.e., your system never would have started) or not at all.

That means the ld.so binary is loaded incorrectly, either because of
disk or RAM errors.  I would guess the later.

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/4gnp2ijCOnn/RHQRAlHPAJ4sn9jgR4at9jzydprTrLWx+2TXbgCfa+UY
8vgFYOTD5Zy3KXumDviniZo=
=g4Tr
-----END PGP SIGNATURE-----
