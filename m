Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266214AbUG0B1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266214AbUG0B1C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 21:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266219AbUG0B1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 21:27:02 -0400
Received: from smtp1.cwidc.net ([154.33.63.111]:7305 "EHLO smtp1.cwidc.net")
	by vger.kernel.org with ESMTP id S266214AbUG0BRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 21:17:30 -0400
Message-ID: <4105AD1C.2050507@tequila.co.jp>
Date: Tue, 27 Jul 2004 10:17:16 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040724
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kernel@kolivas.org, Joel.Becker@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
References: <cone.1090801520.852584.20693.502@pc.kolivas.org>	<20040725173652.274dcac6.akpm@osdl.org>	<cone.1090802581.972906.20693.502@pc.kolivas.org>	<20040726202946.GD26075@ca-server1.us.oracle.com>	<20040726134258.37531648.akpm@osdl.org>	<cone.1090882721.156452.20693.502@pc.kolivas.org>	<4105A761.9090905@tequila.co.jp> <20040726180943.4c871e4f.akpm@osdl.org>
In-Reply-To: <20040726180943.4c871e4f.akpm@osdl.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
| Clemens Schwaighofer <cs@tequila.co.jp> wrote:

|>I have 1 GB and I had a setting of 51 (seemed to be perhaps gentoo
|>default or so) and I especially after a weekend (2 days off) it is
|>always the "monday-morning-swap-hell" where I have to wait 5min until he
|>swapped in the apps he swapped out during weekend.
|>
|>I changed that to 20 now, but I don't know if this will make things
|>worse or better.
|
| It may appear to be better, but you now have 100, maybe 200 megabytes less
| pagecache available across the entire working day.

which might slow down overall working speed? or responsness of programs?

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBBa0bjBz/yQjBxz8RAmcQAJ4ieXmCIBpmeWQ1+kdVEPI0te7ezQCgppxG
AFA1t88+WofCN2WbjmpkZ7A=
=JVwT
-----END PGP SIGNATURE-----
