Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUG0AxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUG0AxB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 20:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUG0AxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 20:53:01 -0400
Received: from smtp1.cwidc.net ([154.33.63.111]:26879 "EHLO smtp1.cwidc.net")
	by vger.kernel.org with ESMTP id S265234AbUG0Aw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 20:52:58 -0400
Message-ID: <4105A761.9090905@tequila.co.jp>
Date: Tue, 27 Jul 2004 09:52:49 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040724
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, Joel Becker <Joel.Becker@oracle.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
References: <cone.1090801520.852584.20693.502@pc.kolivas.org> <20040725173652.274dcac6.akpm@osdl.org> <cone.1090802581.972906.20693.502@pc.kolivas.org> <20040726202946.GD26075@ca-server1.us.oracle.com> <20040726134258.37531648.akpm@osdl.org> <cone.1090882721.156452.20693.502@pc.kolivas.org>
In-Reply-To: <cone.1090882721.156452.20693.502@pc.kolivas.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Con Kolivas wrote:
| Andrew Morton writes:

|> Yes, I think 60% is about right for a 512-768M box.  Too high for the
|> smaller machines, too low for the larger ones.
|
|
| Sigh..
| I have a 1Gb desktop machine that refuses to keep my applications in ram
| overnight if I have a swappiness higher than the default so I think lots
| of desktop users with more ram will be unhappy with higher settings.

I have 1 GB and I had a setting of 51 (seemed to be perhaps gentoo
default or so) and I especially after a weekend (2 days off) it is
always the "monday-morning-swap-hell" where I have to wait 5min until he
swapped in the apps he swapped out during weekend.

I changed that to 20 now, but I don't know if this will make things
worse or better.

|> More intelligent selection of the initial value is needed.
|
| Perhaps, but I really doubt desktop users running mainline would be
| happy about it going significantly higher.

no, but an already diskussed feature that would know, not to swap out
much used apps (eg mozilla which is used all the time, or openoffice)
during night or long idle times, if not _really_ needed.

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBBadgjBz/yQjBxz8RAkj5AJ9527iKCfaJyWI4S8cDvKCIcyC7ZACgyqel
txTVMqqVJUuargYPnX8Fvyw=
=gmPf
-----END PGP SIGNATURE-----
