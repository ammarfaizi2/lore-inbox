Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbTIKN3v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 09:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbTIKN3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 09:29:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63301 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261279AbTIKN3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 09:29:50 -0400
To: "David Schwartz" <davids@webmaster.com>
Cc: "Pascal Schmidt" <der.eremit@email.de>, <linux-kernel@vger.kernel.org>
Subject: Re: People, not GPL  [was: Re: Driver Model]
References: <MDEHLPKNGKAHNMBLJOLKAEIKGHAA.davids@webmaster.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Sep 2003 07:30:10 -0600
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEIKGHAA.davids@webmaster.com>
Message-ID: <m14qzjmp0d.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Schwartz" <davids@webmaster.com> writes:

> 	The GPL_ONLY stuff is an attempt to restrict use. There is nothing
> inherently wrong with attempts to restrict use. One could argue that the
> root permission check on 'umount' is a restriction on use. Surely the GPL
> doesn't mean you can't have any usage restrictions at all.

No the GPL_ONLY stuff is an attempt to document that there is no conceivable
way that using a given symbol does not create a derived work.  

If you use an unmodified kernel it is only a one liner to ensure it does
not complain about your code.  So this only shows up as a real
impediment when code that uses the symbol is distributed.

Beyond which copying code into the kernel is when this is checked so this is
a valid place to check things.  There is a strong tying between using
programs and copying them into memory.  And that copying is the
justification for most usage restrictions even in commercial software.

The code is also quite a small nit that really should not affect
anything.

Eric
