Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbTETB7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 21:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbTETB7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 21:59:13 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:46222
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263449AbTETB7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 21:59:13 -0400
Message-ID: <3EC98EE7.40107@redhat.com>
Date: Mon, 19 May 2003 19:11:51 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030516
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
References: <20030520014836.C7BDE2C069@lists.samba.org>
In-Reply-To: <20030520014836.C7BDE2C069@lists.samba.org>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rusty Russell wrote:

> People are using the interface, so I don't think changing it because
> "it's nicer this way" is worthwhile: Ingo's "new syscall" patch has
> backwards compat code for the old syscalls.

But not the new requeue variant and this is what needs the extra
parameter.  So the parameter question is not issue.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+yY7n2ijCOnn/RHQRAuwkAJ93BCAOgeebWmWvClkYLCiE7CHAIwCgmu6N
9xteUehAOkcGrOWnPL5Wi5U=
=lHNT
-----END PGP SIGNATURE-----

