Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTEEJjD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 05:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbTEEJjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 05:39:03 -0400
Received: from pop.gmx.net ([213.165.65.60]:32332 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262123AbTEEJjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 05:39:02 -0400
Message-ID: <3EB6341B.9000700@gmx.net>
Date: Mon, 05 May 2003 11:51:23 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Felix von Leitner <felix-kernel@fefe.de>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.68] Scalability issues
References: <20030504173956.GA28370@codeblau.de> <20030504194451.GA29196@codeblau.de> <1052079133.27465.14.camel@rth.ninka.net> <20030505075118.GA352@codeblau.de>
In-Reply-To: <20030505075118.GA352@codeblau.de>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner wrote:
> Thus spake David S. Miller (davem@redhat.com):
> 
>>>Here is the ksymoops output.  The taint came from the nvidia kernel
>>>module, X was not running, so the module did not do anything at the
>>>time.
>>
>>Not true, if it got loaded it did something.
>>
>>Either reproduce without the nvidia module loaded, or take
>>your report to nvidia.
> 
> Thank you for this stunning display of unprofessionalism and zealotry.

No, we have to thank you for that.

> People like you keep free software alive.

Yes indeed.
me@linux:~> grep -iC4 "davem" MAINTAINERS
 CRYPTO API
 P:     James Morris
 M:     jmorris@intercode.com.au
 P:     David S. Miller
 M:     davem@redhat.com
 W      http://samba.org/~jamesm/crypto/
 L:     linux-kernel@vger.kernel.org
 S:     Maintained

--
 S:     Maintained

 NETWORKING [IPv4/IPv6]
 P:     David S. Miller
 M:     davem@redhat.com
 P:     Alexey Kuznetsov
 M:     kuznet@ms2.inr.ac.ru
 P:     Pekka Savola (ipv6)
 M:     pekkas@netcore.fi
--
 S:     Maintained

 UltraSPARC (sparc64):
 P:     David S. Miller
 M:     davem@redhat.com
 P:     Eddie C. Dost
 M:     ecd@skynet.be
 P:     Jakub Jelinek
 M:     jj@sunsite.ms.mff.cuni.cz
me@linux:~> grep -iC4 "felix" MAINTAINERS CREDITS
me@linux:~> grep -iC4 "fefe" MAINTAINERS CREDITS
me@linux:~> grep -iC4 "leitner" MAINTAINERS CREDITS
me@linux:~>

Over and out.

