Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268665AbUHLTSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268665AbUHLTSJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 15:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268669AbUHLTSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 15:18:09 -0400
Received: from [82.154.234.81] ([82.154.234.81]:25472 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S268665AbUHLTSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 15:18:05 -0400
Message-ID: <411BC284.6080807@vgertech.com>
Date: Thu, 12 Aug 2004 20:18:28 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040528 Thunderbird/0.6 Mnenhy/0.6.0.103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.8-rc4-bk1 problem: unregister_netdevice: waiting for ppp0 to
 become free. Usage count = 1
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi!

With 2.6.8-rc4-bk1 I get "Aug 12 17:33:10 puma kernel:
unregister_netdevice: waiting for ppp0 to become free. Usage count = 1"
in the logs after pppd exit.

Also, the box won't reboot and print that message forever in the
console. sysrq-U && sysrq-R did it :-)

The last version I tried was 2.6.8-rc2-bk11 and, wrt this prob, is
running fine. So, the problem is in that window and the changelog for
rc4 mentions something about ppp:
http://kernel.org/pub/linux/kernel/v2.6/testing/ChangeLog-2.6.8-rc4

If someone requires more information or tests feel free to ask!

Regards,
Nuno Silva

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBG8KDOPig54MP17wRArTNAKCkY2p0NqKYesxDAUvA7JraQO607QCgoDwo
4v/jnMy2G4jRL9AwALjUzLs=
=f0cy
-----END PGP SIGNATURE-----
