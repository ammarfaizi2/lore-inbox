Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269030AbUIHJOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269030AbUIHJOl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269040AbUIHJOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:14:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62950 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269030AbUIHJOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:14:38 -0400
Message-ID: <413ECD62.5050904@redhat.com>
Date: Wed, 08 Sep 2004 02:14:10 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Remove SCM_CONNECT
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The symbol is defined in linux/include/socket.h but not used anywhere.
The type mentioned in the definition (struct scm_connect) is not defined
anywhere.  So, maybe it's time to remove this macro, it's just
irritating (at least me).

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBPs1i2ijCOnn/RHQRAn1SAJ9Yh6LLieGKVbyfALNWscZb99X56QCgkKmZ
08Czm4oFjcaHUzj9Mx5LZAc=
=8Ezx
-----END PGP SIGNATURE-----
