Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269310AbUI3P4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269310AbUI3P4z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 11:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269312AbUI3P4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 11:56:24 -0400
Received: from w130.z209220038.sjc-ca.dsl.cnc.net ([209.220.38.130]:13051 "EHLO
	mail.inostor.com") by vger.kernel.org with ESMTP id S269310AbUI3Pyf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 11:54:35 -0400
Message-ID: <415C2C25.7030807@inostor.com>
Date: Thu, 30 Sep 2004 08:54:13 -0700
From: Tom Dickson <tdickson@inostor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Why doesn't memchr appear in ksyms?
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to
http://kernelnewbies.org/documents/kdoc/kernel-api/r1708.html I should
be able to use memchr in a module, however, when I try to load the
module insmod complains that memchr is not available; a grep memchr
/proc/ksyms shows that it doesn't exist.

Is there some special kernel option I have to set to enable it? memcpy
and other mem* externs are there.

Thank you (for answering a simple question)

Kernel 2.4.26 on a Pentium 3 system

- -Tom
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBXCwl2dxAfYNwANIRAm/RAJ0ab0hJH/8IaV9gOW7cTWe6z5E6agCgm2hu
F20XzDvW3Ah5LJ/2foMxfMw=
=0qgy
-----END PGP SIGNATURE-----
