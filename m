Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262840AbVAQSTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbVAQSTZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbVAQSP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:15:57 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:8084 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262826AbVAQSMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 13:12:48 -0500
Message-ID: <41EC0024.9010708@comcast.net>
Date: Mon, 17 Jan 2005 13:12:52 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux Kernel Audit Project?
References: <41EB6691.10905@comcast.net>  <41EB6BD6.5070702@comcast.net> <1105962233.12709.68.camel@localhost.localdomain>
In-Reply-To: <1105962233.12709.68.camel@localhost.localdomain>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Alan Cox wrote:
> On Llu, 2005-01-17 at 07:40, John Richard Moser wrote:
> 
>>On the same line, I've been graphing Ubuntu Linux Security Notices for a
>>while.  I've noticed that in the last 5, the number of kernel-related
>>vulnerabilities has doubled (3 more).  This disturbs me.
> 
> 
> I've been monitoring the kernel security stuff for a long time too.
> There are several obvious trends and I think most are positive
> 
> - Tools like coverity and sparse are significantly increasing the number
> of flaws found. In particular they are turning up long time flaws in
> code, but they also mean new flaws of that type are being found. People
> aren't really turning these tools onto user space - yet -
> 

These are great, but I don't think such tools could cover all issues,
especially in the kernel (where hardware is a factor).  Perhaps by
hammering a function with every input possible, but eh.

Humans create the tools, humans create the flaws.  Thus, humans create
flaws in the tools.  Humans of course aren't staticly flawed (as the
tools will be), so they or other humans can notice bugs they missed before.

> - We get bursts of holes of a given type. If you plot things like
> "buffer overflow" "structure passed to user space not cleaned" "maths
> overflow check error" against time you'll see they show definite
> patterns with spikes decaying at different rates towards zero.
> 

\o/

> There are also people other than Linus who read every single changeset.
> I do for one.
> 

"Read" and "Audit" are two different things.  I can read a changeset and
see that a[10] got a 20 character string into it; I will NOT see that a
particular execution path 17 function calls long under one obscure but
possible and deliberately activatable condition causes memory corruption.

I thought the purpose of an audit was to sit down and give the code
several long, hard looks from different perspectives; though I've never
done one (I hope to in the future), so I wouldn't know would I?

Maybe I should stop talking before I make myself look stupider...

> Alan

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7AAjhDd4aOud5P8RAlQqAJ9eVwAClqkqMLETCyIFC6UeyKX0ogCfUUwN
2EWlPWnym7IHz4a/bVBQHmU=
=VpA2
-----END PGP SIGNATURE-----
