Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbTD1BaO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 21:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbTD1BaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 21:30:13 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:36490
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263118AbTD1BaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 21:30:13 -0400
Message-ID: <3EAC86C4.5070200@redhat.com>
Date: Sun, 27 Apr 2003 18:41:24 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030426
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Mark Grosberg <mark@nolab.conman.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Combined fork-exec syscall.
References: <Pine.BSO.4.44.0304272036360.23296-100000@kwalitee.nolab.conman.org> <Pine.LNX.4.50.0304271814410.7601-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.50.0304271814410.7601-100000@blue1.dev.mcafeelabs.com>
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Davide Libenzi wrote:

> This is very much library stuff. I don't think that saving a couple of
> system calls will give you an edge, expecially when we're talking of
> spawning another process. Even if the process itself does nothing but
> return. Ulrich might be eventually interested ...

POSIX has a spawn interface, see <spawn.h> on modern systems.  A syscall
should be compatible with this interface.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+rIbE2ijCOnn/RHQRAstmAKClxTVl6JUUsKycwat1o3UGqPF64wCgsH5j
imxS5VWcVU0li0nNK2Aa99o=
=Z49l
-----END PGP SIGNATURE-----

