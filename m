Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbTLWNAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 08:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbTLWNAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 08:00:41 -0500
Received: from camus.xss.co.at ([194.152.162.19]:62980 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S265125AbTLWNAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 08:00:39 -0500
Message-ID: <3FE83C6B.6040908@xss.co.at>
Date: Tue, 23 Dec 2003 14:00:27 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: mpt_linux_developer@lsil.com
Subject: 2.4.23, 2.4.24-pre: Boot option "nosmp" broken?
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

When I try to boot an SMP kernel on an Dual Xeon system
(Asus PR-DLS533 motherboard) with option "nosmp", the
Fusion MPT driver does not work anymore: It prints a startup
message, can't find any device on the SCSI bus and keeps
resetting the bus on and on.

Messages look something like this (copied from memory by hand,
as the system obviously can't write logfiles to the disk... ;-):
[...]
Fusion MPT base driver 2.05.05+
Copyright (c) 1999-2002 LSI Logic Corporation
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
mptbase: Initiating ioc0 recovery
mptbase: Initiating ioc0 recovery
mptbase: Initiating ioc0 recovery
[...]

I verified this behaviour with linux 2.4.23 and 2.4.24-pre2
and Fusion MPT drivers 2.05.05+ (original) and 2.05.10 (patched)

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/6DxpxJmyeGcXPhERAk05AJ9blmW44tfQUIkO+SAizxdecv74hACePG2/
0KwfHv0kd2w55EnHWggFQ+I=
=eX3J
-----END PGP SIGNATURE-----

