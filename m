Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264447AbTEJRKu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 13:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTEJRKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 13:10:50 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:8858 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S264447AbTEJRKt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 13:10:49 -0400
Message-ID: <3EBD357F.6050809@redhat.com>
Date: Sat, 10 May 2003 10:23:11 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030506
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 uaccess to fixmap pages
References: <20030509124042.GB25569@mail.jlokier.co.uk> <Pine.LNX.4.44.0305090856500.9705-100000@home.transmeta.com> <b9hrhg$5v7$1@cesium.transmeta.com> <20030510153156.GA29271@mail.jlokier.co.uk>
In-Reply-To: <20030510153156.GA29271@mail.jlokier.co.uk>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jamie Lokier wrote:

> I suspect this would cause difficulties with the latest ELF and unwind
> tables, but apart from that, why _not_ place the vsyscall trampoline
> at the end of the stack?

The unwind information is in a position-independent form.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+vTV/2ijCOnn/RHQRAvXPAKCaq5W34wOVwh3sMBw8fqlcQ1TuvgCfQZkQ
EoyJ6njw/JKg2rTbcAScmkU=
=ao0g
-----END PGP SIGNATURE-----

