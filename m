Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263777AbUEXAjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUEXAjl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 20:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUEXAjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 20:39:41 -0400
Received: from smtp4.cwidc.net ([154.33.63.114]:31712 "EHLO smtp4.cwidc.net")
	by vger.kernel.org with ESMTP id S263777AbUEXAjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 20:39:40 -0400
Message-ID: <40B14444.1020307@tequila.co.jp>
Date: Mon, 24 May 2004 09:39:32 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: Tequila \ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040308
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-mm3: i810 agpgart module can't be initialized
References: <20040523105557.115b91a0.khali@linux-fr.org>
In-Reply-To: <20040523105557.115b91a0.khali@linux-fr.org>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jean Delvare wrote:
| Hi Clemens,
|
| Could be that you have the i2c-i810 driver loaded. Both drivers (i2c and
| fb) request the PCI device AFAIK, so they are mutually exclusive.
|
| Both drivers should proably be merged so as to solve that issue, but
| nodoby seems to be interested in working on this right now. And I won't
| do it, I don't even have compatible hardware to test on.

well they shouldn't, shouldn't they. Anyway in mm4 this problem doesn't
exist anymore.

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsUREjBz/yQjBxz8RAtKQAKC2XS8HzUcJDp6vlJJgLqMDehl5HwCgtZ7I
xfPWVArBnTEkFHujUZLE0d4=
=NOy+
-----END PGP SIGNATURE-----
