Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUGJITH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUGJITH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 04:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUGJITH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 04:19:07 -0400
Received: from mail.enyo.de ([212.9.189.167]:20240 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S266187AbUGJITG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 04:19:06 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Sat, 10 Jul 2004 10:18:57 +0200
In-Reply-To: <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 7 Jul 2004 22:19:53 -0700 (PDT)")
Message-ID: <87llhsp95a.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds:

> "0" is an _integer_. It's not a pointer.

It's neither.  It's a literal.  Context may turn it into something
else, though.
