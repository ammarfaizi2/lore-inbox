Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbSJSRZk>; Sat, 19 Oct 2002 13:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265634AbSJSRZj>; Sat, 19 Oct 2002 13:25:39 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:55202
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265633AbSJSRZj>; Sat, 19 Oct 2002 13:25:39 -0400
Message-ID: <3DB19716.8070804@redhat.com>
Date: Sat, 19 Oct 2002 10:32:06 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021014
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: phil-list@redhat.com
CC: dan@debian.org, mingo@elte.hu, mgross@unix-os.sc.intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
References: <Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain> <200210180004.g9I04OP17510@unix-os.sc.intel.com> <20021018004847.GA27817@nevyn.them.org> <200210191320.g9JDKJWs001201@elgar.kettenis.dyndns.org>
In-Reply-To: <Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mark Kettenis wrote:

>  We should change it in
> GDB/BFD instead from 0x46e62b7f.  The value 20 is already publically
> available in the current kernel headers and glibc headers.  What are
> your feelings about that, Ingo?


This is definitely the right way to go.  Updating gdb isn't that
problematic.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9sZcX2ijCOnn/RHQRAl4OAJwJiBPh44rUJeb2vAqCp21p1FczsgCgoTiH
xvIUxOcAKO0SQczIbIczDjk=
=ZL5J
-----END PGP SIGNATURE-----

