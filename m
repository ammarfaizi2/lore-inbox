Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbTD1CHo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 22:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbTD1CHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 22:07:44 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:43658
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263361AbTD1CHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 22:07:43 -0400
Message-ID: <3EAC8F9A.4040401@redhat.com>
Date: Sun, 27 Apr 2003 19:19:06 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030426
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Grosberg <mark@nolab.conman.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Combined fork-exec syscall.
References: <Pine.BSO.4.44.0304272145580.23296-100000@kwalitee.nolab.conman.org>
In-Reply-To: <Pine.BSO.4.44.0304272145580.23296-100000@kwalitee.nolab.conman.org>
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mark Grosberg wrote:

> Would my original proposal cover the POSIX spec with some userland glue?

No.  The additional work has to be done in the child before exec.  The
whole point is to not leave the kernel.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+rI+a2ijCOnn/RHQRAkQhAJ9pG+yBJJOyWlHtU7emXBy5gN/hLACfYXmg
UcGYeu2DEWXX6utwaZVBdAA=
=1Lee
-----END PGP SIGNATURE-----

