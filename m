Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264748AbUDWIU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264748AbUDWIU4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 04:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264749AbUDWIU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 04:20:56 -0400
Received: from d594e6ae.dsl.concepts.nl ([213.148.230.174]:49581 "EHLO
	server.thuis.lan") by vger.kernel.org with ESMTP id S264748AbUDWIUz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 04:20:55 -0400
Message-ID: <4088D1E3.1050901@xs4all.nl>
Date: Fri, 23 Apr 2004 10:20:51 +0200
From: Rik van Ballegooijen <sleightofmind@xs4all.nl>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: nvidia binary driver broken with 2.6.6-rc{1,2}, reverting a -mm patch
 makes it work
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Because of a patch from -mm merged in mainstream i cannot get the nvidia
binary to work with the 2.6.6 release candidates. I get this message
when doing `modprobe nvidia`:

FATAL: Error inserting nvidia (/lib/modules/2.6.6-rc2/video/nvidia.ko):
Invalid module format

On advice of mcp i tried reverting the following patch, which made it
load again.

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc3/2.6.5-rc3-mm4/broken-out/move-__this_module-to-modpost.patch

Is there any long-term solution for this comming up? TIA

- -Rik
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAiNHjq1cnhHKeD68RAnGVAKC3LWYr43fRkJJ5gshQH2Z/APeohACg6uO3
Q4I+pRmByE0PLSQuZXMSSBI=
=JEbV
-----END PGP SIGNATURE-----
