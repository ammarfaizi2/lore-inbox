Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUALRQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 12:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265309AbUALRQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 12:16:47 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:65022 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261406AbUALRQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 12:16:46 -0500
Message-ID: <4002D65C.1010505@eglifamily.dnsalias.net>
Date: Mon, 12 Jan 2004 10:16:12 -0700
From: Dan Egli <dan@eglifamily.dnsalias.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Subject: 2.6.x breaks some Berkeley/Sleepycat DB functionality
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dan@eglifamily.dnsalias.net
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have encountered a strange issue in 2.6.0 and 2.6.1

I run a PGP Public key server on this machine and under 2.4.x it's
"smooth as silk". But if I boot under 2.6.x, it's gaurenteed failure. If
I try to build a database using the build command (this is an sks
server, so it's sks build or sks fastbuild) I IMMEDIATELY get  Bdb
error. But the exact same command with the exact same libraries and
input files under 2.4.20 works without a hitch.

Anyone got any ideas? Anything else I can provide to assist in debugging?

- --- Dan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAAtZctwT22Jak4/4RAk+nAJ4tclsoZTI/a2LAwxb81KOrPxHLhQCcDxoP
Dlbr7aZabky+CeBGD9TnjY4=
=dr0q
-----END PGP SIGNATURE-----

