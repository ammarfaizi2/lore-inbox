Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291460AbSCOXy3>; Fri, 15 Mar 2002 18:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291340AbSCOXyK>; Fri, 15 Mar 2002 18:54:10 -0500
Received: from mail.webmaster.com ([216.152.64.131]:54005 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S291333AbSCOXxy> convert rfc822-to-8bit; Fri, 15 Mar 2002 18:53:54 -0500
From: David Schwartz <davids@webmaster.com>
To: <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (1003) - Registered Version
Date: Fri, 15 Mar 2002 15:53:51 -0800
In-Reply-To: <E16m1bl-000554-00@the-village.bc.nu>
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020315235352.AAA221@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I'm not saying the RFC is a good idea (tho its a needed patch to use Linux
>for backbone routing sanely with most vendors BGP kit). Your argument about
>the RST frame is however pure horseshit
>
>Alan

	I don't think it's a good idea either, and I'm sorry this turned into an 
argument over the merits of RFC2385. I don't like it, and that's one of the 
reasons I didn't suggest a thorough implementation. I just want enough to 
solve the particular problem that I have, which is that Zebra on Linux can't 
interoperate with Cisco BGP implementations using MD5 authentication.

	There is some merit to the argument that one shouldn't crap up a network 
stack just because someone else did. The question is, is interoperability 
worth this small piece of crap. I personally think it is, but I'm prejudiced 
since I happen to need it.

	I'm trying to decide if I need it badly enough to make it worth the effort 
it would take to implement it. One factor that would go into that decision is 
whether the patch would have a chance at being accepted into the kernel or 
whether at least kernel hooks to allow it to be implemented as a module might 
be accepted.

	DS


