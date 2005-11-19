Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVKSAsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVKSAsH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 19:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVKSAsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 19:48:06 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:13676 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751250AbVKSAsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 19:48:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=MU5ljINwzBK4iUAyrDTF4bVQb0Bc4I9CvYw++MtID1PISMFFopzd9sZWxOJ0hyQeQMBPcOS9kYLExUIIO/6OqS5Myz69j/a5krVN7rH/4MbFw8PG7Kt7PQdDcd3bwJ/26D31Fo2v34Azf3y/1HtLiVnB/39nafRGspAxkxCBPqk=
Message-ID: <437E76CC.4000202@gmail.com>
Date: Sat, 19 Nov 2005 01:50:20 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: "K.R. Foley" <kr@cybsft.com>
CC: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       john cooper <john.cooper@timesys.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Softlockup detected with linux-2.6.14-rt6
References: <4378B48E.6010006@gmail.com> <20051115153257.GA9727@elte.hu> <437A14FB.8050206@timesys.com> <20051115200010.GA13802@elte.hu> <Pine.LNX.4.64.0511151206000.29907@dhcp153.mvista.com> <437A7A58.8050209@gmail.com> <437DF0A8.6060409@gmail.com> <437E1E95.2010809@cybsft.com>
In-Reply-To: <437E1E95.2010809@cybsft.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

K.R. Foley ha scritto:
|> The slow booting sounds a lot like the RCU_TORTURE_TEST slowing things
|> down. You might try turning off RCU_TORTURE_TEST or setting it to be a
|> module.

RCU torture test is not compiled at all
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQ352ypK+HIH6ZZ2zAQKyKAf8DCP61LE52PSx7yedqof2G9qGfhqa6Tiz
/tgTfAmzzsQ2KvQUiYIDU5snmZmM5vbMYvtv07T/D+E5o/9BqIa8yJt1mFh0EcPr
uOGljrUTCyNdR+4LXe2H8Tdacc7k0DOjfxxDDoTKJoWv6al4a+K5FAy6wxfHIr2t
whpsceXSZxyRPY9EmOpupFxcGjnoq+ywURqPHm3D8qVfSJwT24U9bRu/7hkrbFy6
lRJQssnD7o/Dcf+xtuvQkDD5AzrcOVdI8KDGD1AO+S7pGcnPAxA0aPdeCQsUuOs5
RF6Z7VeQuBvffuxSXW7BgGNA9W0aA+UZMFw0qVkqrjblTTp/QhcExA==
=Qjq4
-----END PGP SIGNATURE-----
