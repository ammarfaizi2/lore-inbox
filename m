Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266214AbUFJG5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266214AbUFJG5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 02:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266182AbUFJGzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 02:55:24 -0400
Received: from smtp2.cwidc.net ([154.33.63.112]:19636 "EHLO smtp2.cwidc.net")
	by vger.kernel.org with ESMTP id S266214AbUFJGzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 02:55:04 -0400
Message-ID: <40C805BA.6080008@tequila.co.jp>
Date: Thu, 10 Jun 2004 15:54:50 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\ Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040308
X-Accept-Language: en-us, en, ja
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm1
References: <20040609015001.31d249ca.akpm@osdl.org> <40C7EE96.4020206@tequila.co.jp> <20040610053134.GV1444@holomorphy.com>
In-Reply-To: <20040610053134.GV1444@holomorphy.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

William Lee Irwin III wrote:
| On Thu, Jun 10, 2004 at 02:16:06PM +0900, Clemens Schwaighofer wrote:
|
|>compile error in:
|>drivers/perfctr/x86.c: In function `finalise_backpatching':
|>drivers/perfctr/x86.c:1137: error: parse error before '{' token
|>make[2]: *** [drivers/perfctr/x86.o] Error 1
|>make[1]: *** [drivers/perfctr] Error 2
|>make: *** [drivers] Error 2
|>the kernel compiled fine with 2.6.7-rc2-mm2.
|>config attached.
|
|
| You will likely need other fixes, but...

That patch fixes it for me and I can boot without a problem

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.co.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAyAW5jBz/yQjBxz8RAnMhAKCOBxRrHh1syVCbo7Kk09N+wl53ywCeNl+K
MsClpNoaWw/31qA8vQQF/mE=
=uglM
-----END PGP SIGNATURE-----
