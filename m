Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTKDWAt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 17:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTKDWAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 17:00:49 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:57547
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262609AbTKDWAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 17:00:48 -0500
Message-ID: <3FA82161.9000507@redhat.com>
Date: Tue, 04 Nov 2003 14:00:01 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Paul Venezia <pvenezia@jpj.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ext3 performance inconsistencies, 2.4/2.6
References: <Pine.LNX.4.44.0311041335200.20373-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0311041335200.20373-100000@home.osdl.org>
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:

> Don't ask me why. But I'm cc'ing Uli, who can probably tell us. Maybe the 
> RH-9 libraries are just not very good, and LinuxThreads has had a lot 
> longer to optimize their lock behaviour..

I don't see any verison numbers mentioned.  If you want to benchmark
NPTL use the recent code, e.g., from Fedora Core 1 or RHEL3.  Nothing
else makes any sense since there have mean countless changes since the
early releases.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/qCFh2ijCOnn/RHQRApi1AKCaU7vBtJsATDmx2dStMYishtbF9wCaAvOe
kNaoizj4xtUNU4TV2wH5GAw=
=0kb0
-----END PGP SIGNATURE-----

