Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUGHPqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUGHPqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 11:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUGHPqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 11:46:36 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:41223 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264627AbUGHPqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 11:46:35 -0400
Message-ID: <40ED71BC.2030609@techsource.com>
Date: Thu, 08 Jul 2004 12:09:32 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:

> It's not about "unsafe". It's about being WRONG.
> 
> The fact is, people who write "0" are either living in the stone age, or 
> are not sure about the type. "0" is an _integer_. It's not a pointer. It 
> may be legal C, but that doesn't make it right anyway. "0" also happens to 
> be one of the more _common_ integers, so mistakes happen.

Not to be picky, and I realize that we're not using C++ here, and it may 
not apply, but every C++ text I've read deprecates NULL and says to use 
0.  That is, THE WAY that you specify a null pointer in C++ is with a 
zero.  It's no surprise that C programmers might pick up that habit.


