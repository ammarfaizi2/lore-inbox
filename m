Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263720AbTDGWOp (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263721AbTDGWOp (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:14:45 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:50621
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263720AbTDGWOo (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:14:44 -0400
Message-ID: <3E91FAF0.4060400@redhat.com>
Date: Mon, 07 Apr 2003 15:25:52 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030406
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fredrik Tolf <fredrik@dolda2000.cjb.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
References: <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org> <200304072255.47254.fredrik@dolda2000.cjb.net> <3E91F0FD.1040507@redhat.com> <200304080017.21799.fredrik@dolda2000.cjb.net>
In-Reply-To: <200304080017.21799.fredrik@dolda2000.cjb.net>
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Fredrik Tolf wrote:

> If I've missed the introduction of a fexecve syscall, I'm sorry for wasting 
> your time.

There is no syscall.  The people who don't want to use /proc for
security reasons better come up with fixes to make it acceptable.  The
kernel lacks a number of syscalls which allow getting various pieces of
information and the only way to implement the functionality is via
/proc.  The use of /proc is growing and you'll find that more than just
fexecve() will fail if you don't have /proc.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+kfrw2ijCOnn/RHQRArnmAJ4y6lXO3Msq3NvnnVLp/NHzJK6oUwCgvIFu
Aw+0YsJzlYFtawxSjR5xPEQ=
=SYEg
-----END PGP SIGNATURE-----

