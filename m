Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbTENTcc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbTENTcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:32:32 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:13748
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261179AbTENTcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:32:31 -0400
Message-ID: <3EC29CB2.4030707@redhat.com>
Date: Wed, 14 May 2003 12:44:50 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Christopher Hoover <ch@murgatroid.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
References: <20030513213157.A1063@heavens.murgatroid.com> <20030514071446.A2647@infradead.org> <20030514005213.A3325@heavens.murgatroid.com> <3EC296CE.9050704@redhat.com> <20030514193221.GA28385@suse.de>
In-Reply-To: <20030514193221.GA28385@suse.de>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dave Jones wrote:

> That seems to imply that the current glibc makes futexes mandatory,
> which surely isn't the case or we'd not be able to run with 2.4 and earlier
> kernels.

Current == current development.  LinuxThreads is not developed anymore
and with nptl futexes are mandatory.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+wpyy2ijCOnn/RHQRAv88AJ4mZDNFyre2J6Pku7jkE2JSvV4aBgCgufYG
70N4RNLFQzDNIk3id3UHJUk=
=LqUF
-----END PGP SIGNATURE-----

