Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbTHTRot (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbTHTRot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:44:49 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:39145
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262105AbTHTRos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:44:48 -0400
Message-ID: <3F43B34D.5020503@redhat.com>
Date: Wed, 20 Aug 2003 10:43:41 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030731 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6
References: <3F4268C1.9040608@redhat.com> <shszni499e9.fsf@charged.uio.no>
In-Reply-To: <shszni499e9.fsf@charged.uio.no>
X-Enigmail-Version: 0.81.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Trond Myklebust wrote:

> There are known bugs in the way we handle readdirplus. That's why it
> only hits NFSv3. Does the following patch fix it?

As Andries suspected, no change.  The test still fails.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/Q7NN2ijCOnn/RHQRAmudAKCzj93j8Ih/4jOXP1IcllvTQyAJUQCgmRy0
sJ3FOh4gd6tWLZEV1N75jek=
=p2xm
-----END PGP SIGNATURE-----

