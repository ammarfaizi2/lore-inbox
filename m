Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265239AbTLFUIj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 15:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265242AbTLFUIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 15:08:39 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:61853
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S265239AbTLFUIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 15:08:37 -0500
Message-ID: <3FD23706.7050700@redhat.com>
Date: Sat, 06 Dec 2003 12:07:34 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031121 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@yahoo.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] FIx  'noexec' behavior
References: <20031206200322.86264.qmail@web14902.mail.yahoo.com>
In-Reply-To: <20031206200322.86264.qmail@web14902.mail.yahoo.com>
X-Enigmail-Version: 0.82.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jon Smirl wrote:
 = 0
> 9292  old_mmap(0xbfe0f000, 12288, PROT_READ|PROT_WRITE|PROT_EXEC,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0[jonsmirl@smirl jonsmirl]$

Add "file && " to the beginning of the new conditional and it should work.

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/0jcH2ijCOnn/RHQRAgs4AJ9xSCtZ27lM2hgmDJhW24atTPDHbgCcDWHQ
jfa75LhA4JGRuwBodslzB3A=
=A0T0
-----END PGP SIGNATURE-----
