Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293484AbSCOXOZ>; Fri, 15 Mar 2002 18:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293483AbSCOXOP>; Fri, 15 Mar 2002 18:14:15 -0500
Received: from mail.webmaster.com ([216.152.64.131]:61927 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S293482AbSCOXOC> convert rfc822-to-8bit; Fri, 15 Mar 2002 18:14:02 -0500
From: David Schwartz <davids@webmaster.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (1003) - Registered Version
Date: Fri, 15 Mar 2002 15:13:59 -0800
In-Reply-To: <E16m0vU-0004xU-00@the-village.bc.nu>
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020315231400.AAA28257@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Not only that MD5 shouldn't be the one. The crypto folks prefer SHA and for
>good reasons.

	There is no problem with MD5 that makes it unsuitable for this particular 
application. A SHA signature would enlarge each packet, further reducing the 
effective MTU. This would increase the cost of what was intended to be a 
simple mechanism to solve a specific problem (spoofed SYNs/RSTs).

	What it comes down to is simply whether you care whether Linux machines can 
interoperate with Cisco's BGP authentication scheme. This feature would be 
very useful to me, so I personally do care, even if the scheme is not the 
best possible scheme.

	DS


