Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753067AbVHGXr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbVHGXr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 19:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753125AbVHGXr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 19:47:59 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:468 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1753067AbVHGXr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 19:47:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=b8jouwLU+Ut67Y1jw5JnVdaUjJZdrFLzS87KElzH45zId37bYKAAtW8PF/tar0ehcNN0WExjFsYFE4rf9Xn89TqoUkyI1Tl53CqBBP/u98C1UEFul/fsJhZllBzhhyRJ7yDXhi1Fw0A/nNPRrY4APxwb6yGpeoMrOjXTSmM3OJk=
Message-ID: <42F6266B.8000704@gmail.com>
Date: Sun, 07 Aug 2005 15:19:07 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: rddunlap@osdl.org, fastboot@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kexec and frame buffer
References: <42F219B3.6090502@gmail.com>	<m17jf1zgnz.fsf@ebiederm.dsl.xmission.com>	<42F4C6E8.1050605@gmail.com> <m13bpnyppq.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m13bpnyppq.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eric W. Biederman ha scritto:
> Anyway I believe you also want to look at include/linux/tty.h
> at the screen_info structure.  I believe that is where
> all of that information is passed.
I noticed. Maybe if we fill struct x86_linux_param_header with some values
obtained from struct screen_info, we should be able to "score that mid-court
prayer" ;)

>>I tried to pass --real-mode flag to kexec but my virtual machine doesn't like
>>it. When I launch kexec -e, it tells me: "A strange behaviour occourred which
>>crashed virtual machine".
>
>
> Cool.  I haven't used that code in a long time but it is pretty
> trivial code to switches to real mode so I don't really doubt it :)
Added to my list-of-things-to-do-after-holydays :)

Regards,
- --
					Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQvYmaszkDT3RfMB6AQLPMQf/W3HZbJj50rxI1LOHyw0hhcQZji+gU68R
E88xmgbL1fuiQqdqD1vp3gG7uDf9jjE+TjNMQ1qgZr01xHUjV13Jq8e9Lu75S+RZ
JgiYJxFKGY/ctl9oFgEraU9Qje1b18dTmYh5G4xfZLNjUFUM1uQowV6CSPLVRadv
ucmzduDrqwRBQgN9vSrWPoLio8nbT5ZjxLjaY1z3P3EYXoBs9LLx1bjzLmR7/cVe
MP3/BM61CLqflOG9G+ck9yD2RIYnLhvNHDBKt1X+oP+U/iSkzse3XEM/YVny6/3d
zAYy8m66o2bPnj/vNcBbroxANTdiXJce8QWayk9a69c26DmjOLnYrQ==
=iPn6
-----END PGP SIGNATURE-----

