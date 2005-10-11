Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbVJKD4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbVJKD4I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 23:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbVJKD4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 23:56:08 -0400
Received: from xproxy.gmail.com ([66.249.82.193]:64244 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750982AbVJKD4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 23:56:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=YEmBnCsKMm48UBZ0Va73P8dxiqRNPKugij1qWHOglJQTBvU2juIGz8015fB22zyqSg35uMAW+N2aGgJuSI26XKt1xEnFxKh5MOJE69kDBQQtRCe1mUE8mDWcCJ7PyicqRNAmXN7+xWGyT2GVqj03NRlPxx3Rgj336djTs4sL7v4=
Message-ID: <434B3803.2030803@gmail.com>
Date: Tue, 11 Oct 2005 05:56:51 +0200
From: Matan Peled <chaosite@gmail.com>
Reply-To: chaosite@gmail.com
Organization: Chaosite Destruction, inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050822 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Knecht <markknecht@gmail.com>
CC: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: Latency data - 2.6.14-rc3-rt13
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>	 <1128977359.18782.199.camel@c-67-188-6-232.hsd1.ca.comcast.net>	 <5bdc1c8b0510101412n714c4798v1482254f6f8e0386@mail.gmail.com>	 <5bdc1c8b0510101428o475d9dbct2e9bdcc6b46418c9@mail.gmail.com>	 <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net>	 <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com>	 <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net>	 <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com> <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com>
In-Reply-To: <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=D6F42CA5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mark Knecht wrote:
> Well, I'm disappointed again. Some xruns came but no additional data
> was put into the dmesage file:

"dmesage file"? You mean, "/var/log/dmesg"? No, thats not the file you want...
At least here, that file contains the logs as they were when the boot finishes.

The information you want can be retrieved by running the command (actual program
to run, type it in a terminal) "dmesg".

Or you might be able to look whats in the end of the /var/log/messages file, if
you have one.

- --
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDSzgDA7Qvptb0LKURApE4AKCOxBS3Xos5yEAnd5QbItjRmYlIsQCePSmm
ULBWIDcIOPxXAnMSodZNgCg=
=qmrM
-----END PGP SIGNATURE-----
