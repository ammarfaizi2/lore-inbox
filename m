Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbTFPAa5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 20:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTFPAa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 20:30:56 -0400
Received: from smtp3.cwidc.net ([154.33.63.113]:25492 "EHLO smtp3.cwidc.net")
	by vger.kernel.org with ESMTP id S263163AbTFPAax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 20:30:53 -0400
Message-ID: <3EED12F3.5010602@tequila.co.jp>
Date: Mon, 16 Jun 2003 09:44:35 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5a) Gecko/20030528
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uptime wrong in 2.5.70
References: <Pine.LNX.4.33.0306131117230.12096-100000@gans.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.33.0306131117230.12096-100000@gans.physik3.uni-rostock.de>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tim Schmielau wrote:

>>I a got a test vmware running with a 2.5.70 and I have sligh "overflow"
>>with my uptime.
>>
>>gentoo root # uptime
>> 22:29:47 up 14667 days, 19:08,  3 users,  load average: 0.00, 0.00, 0.00
>
>
> Doesn't ring any bell yet. Can you cat /proc/uptime and /proc/stat output?
> Is this immediately after booting? Reproducable?

gentoo root # cat /proc/uptime
1267537132.92 278990.27
gentoo root # cat /proc/stat
cpu  1542550 0 3915839 27412781 392624
cpu0 1542550 0 3915839 27412781 392624
intr 333933393 332637964 7735 0 0 0 0 3 0 2 0 0 0 7417 0 0 16 0 622268
657988 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt 15529955
btime 4083180513
processes 659768
procs_running 3
procs_blocked 0
gentoo root # uptime
 16:59:20 up 14670 days, 13:39,  3 users,  load average: 1.22, 1.04, 0.49

I will reboot the box now and see if it happens again. but as I read in
other postings to this thread it seams to happen again.

thought I got anohter mail, from David Schwartz who claims that this is
because <quote> This is due to a known bug in the Penitum(R) processor,
which Linux has never claimed to support. </quote>

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+7RLyjBz/yQjBxz8RAtLYAJ4rFrLGtCT7UcX3m+oHJSAssJOf9gCfflW7
b0odmjhcJ7AyZeFMnTwjbag=
=B6J3
-----END PGP SIGNATURE-----

