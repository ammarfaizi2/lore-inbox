Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263696AbTDGV54 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263700AbTDGV54 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:57:56 -0400
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:6773 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id S263696AbTDGV5z (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 17:57:55 -0400
Message-ID: <3E91F71B.2000805@acm.org>
Date: Mon, 07 Apr 2003 17:09:31 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] NMI rework
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I had been working on this in the past, and I've been ignoring it
recently.  But several people have pinged me about it, so I'll bring it
up again.

This is a rework of the NMI handling in Linux on x86 to provide a
list-handler type interface.  So you can request/release a tie-in for
the NMI chain.  Several things tie in to the NMI handling, and this
cleans up the mess that happens when you hack oprofile, IPMI watchdog,
kdb, etc. into the NMI handler.

The patch is at
http://osdn.dl.sourceforge.net/sourceforge/openipmi/linux-nmi-2.5.67-v14.diff. 
It's a little big to post to the list.

- -Corey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+kfcaIXnXXONXERcRAks9AJ9yWj99GOZPjQzwrlTSDBa0f4qUCQCfR93Z
JtGCwGA9ltzTJxbAkx+e7rU=
=tk6p
-----END PGP SIGNATURE-----


