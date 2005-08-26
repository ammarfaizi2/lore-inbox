Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbVHZNid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbVHZNid (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 09:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbVHZNid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 09:38:33 -0400
Received: from [81.2.110.250] ([81.2.110.250]:3017 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751572AbVHZNic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 09:38:32 -0400
Subject: Re: A Great Idea (tm) about reimplementing NLS.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Daniel B." <dsb@smart.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <430E5B8E.5C89A06B@smart.net>
References: <f192987705061303383f77c10c@mail.gmail.com>
	 <f192987705061310202e2d9309@mail.gmail.com>
	 <1118690448.13770.12.camel@localhost.localdomain>
	 <200506152149.06367.pmcfarland@downeast.net>
	 <20050616023630.GC9773@thunk.org> <87y89a7wfn.fsf@jbms.ath.cx>
	 <20050616143727.GC10969@thunk.org>  <20050619175503.GA3193@elf.ucw.cz>
	 <1119292723.3279.0.camel@localhost.localdomain>
	 <430E5B8E.5C89A06B@smart.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 26 Aug 2005 15:07:00 +0100
Message-Id: <1125065221.4958.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-08-25 at 20:00 -0400, Daniel B. wrote:
> Which standards?

Traditional unix namespace is a sequence of bytes with '/' as a
seperator and \0 as a terminator. There are no other restrictions. UTF-8
is essentially a retrofit onto that.

> The standards I've read (mostly XML- and web-related specs)
> do say that non-standard UTF-8 octet sequences should be rejected.

If you follow the thread further various people pointed out that POSIX
and other standard documents are actually more restrictive in their
guarantees so my belief by a strict standards reading is wrong. It'll
break a few apps if you enforced it (lots if you took the minimal posix
requirement).


