Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbSKNA1W>; Wed, 13 Nov 2002 19:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264729AbSKNA1W>; Wed, 13 Nov 2002 19:27:22 -0500
Received: from marcie.netcarrier.net ([216.178.72.21]:12554 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S264706AbSKNA1V>; Wed, 13 Nov 2002 19:27:21 -0500
Message-ID: <3DD2F0FF.D1306F88@compuserve.com>
Date: Wed, 13 Nov 2002 19:40:31 -0500
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: bk current build failures (xfrm.h / tpqic02.c)
Content-Type: multipart/mixed;
 boundary="------------95D28429F2F9EA8AA5D20385"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------95D28429F2F9EA8AA5D20385
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I see the two attached build failures with bk current.

-- 
Kevin
--------------95D28429F2F9EA8AA5D20385
Content-Type: text/plain; charset=us-ascii;
 name="bk_current_bf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bk_current_bf"

net/core/skbuff.c: At top level:
include/net/xfrm.h:104: storage size of `lft' isn't known
include/net/xfrm.h:112: storage size of `replay' isn't known
include/net/xfrm.h:115: storage size of `stats' isn't known
include/net/xfrm.h:117: storage size of `curlft' isn't known
make[2]: *** [net/core/skbuff.o] Error 1


drivers/char/tpqic02.c: In function `__initfn':
drivers/char/tpqic02.c:2798: parse error before "void"
make[2]: *** [drivers/char/tpqic02.o] Error 1

--------------95D28429F2F9EA8AA5D20385--

