Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVCOOMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVCOOMy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVCOOMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:12:54 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:51095 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261255AbVCOOMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:12:52 -0500
Message-ID: <4236ED5F.9020301@g-house.de>
Date: Tue, 15 Mar 2005 15:12:47 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Mauricio Lin <mauriciolin@gmail.com>, elenstev@mesatop.com
Subject: Re: oom with 2.6.11
References: <422DC2F1.7020802@g-house.de>	 <3f250c710503090518526d8b90@mail.gmail.com>	 <3f250c7105030905415cab5192@mail.gmail.com>	 <422F016A.2090107@g-house.de> <423063DB.40905@g-house.de>	 <3f250c7105031101016d7cb08e@mail.gmail.com>	 <4231B4A4.4050207@g-house.de> <3f250c7105031500527007a0e7@mail.gmail.com>
In-Reply-To: <3f250c7105031500527007a0e7@mail.gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mauricio Lin wrote:
>>>
>>>Did this problem start from 2.6.11-rc2-bk10?
>>
>>i noticed it first at 2.6.11, then again with 2.6.11-rc5-bk2. suspecting
>>pppd to be the culprit to chew up all RAM after being terminated by my ISP
>>once a day - i just have to wait (must be around 2a.m.).
> 
> Have you tried with 2.6.10 in order to check this problem?

i don't think i've run plain 2.6.10 at all, syslog does not say so. i've
run several versions of 2.6.9, then 2.6.10-rc1, 2.6.10-rc1-bk19,
2.6.10-rc2-bk9, 2.6.10-rc3-bk11, 2.6.11-rc2-bk10, 2.6.11-rc5-bk2.

as stated earlier, the problem kicked in when i switched to 2.6.11, i
switched back to 2.6.11-rc5-bk2 and it happened again. by looking at the
syslog i am (still) suspecting pppd to be the source of OOM, but it did
not show up as a memory pig in "ps". i am running 2.6.11.3 now and the
machine survived almost 2 passes of pppd's daily hangups. i'll keep an eye
on it.

thank you for your concern,
Christian.
- --
BOFH excuse #357:

I'd love to help you -- it's just that the Boss won't let me near the
computer.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCNu1e+A7rjkF8z0wRAmSPAJ49erb21bO6inHPn/zoUH2gNHJk8QCguYDA
HyzXS9whrJnb9eXVz9IP8zc=
=zhEx
-----END PGP SIGNATURE-----
