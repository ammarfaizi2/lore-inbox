Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVFUSRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVFUSRl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 14:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVFUSRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 14:17:41 -0400
Received: from mail.dvmed.net ([216.237.124.58]:31144 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262165AbVFUSR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 14:17:26 -0400
Message-ID: <42B859B4.5060209@pobox.com>
Date: Tue, 21 Jun 2005 14:17:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: git-pull-script on my linus tree fails..
References: <Pine.LNX.4.58.0506211304320.2915@skynet> <Pine.LNX.4.58.0506210837020.2268@ppc970.osdl.org> <42B838BC.8090601@pobox.com> <Pine.LNX.4.58.0506210905560.2268@ppc970.osdl.org> <42B84E20.7010100@pobox.com> <Pine.LNX.4.58.0506211039350.2268@ppc970.osdl.org> <42B8542A.9020700@pobox.com> <Pine.LNX.4.58.0506211103370.2268@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506211103370.2268@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> No, you don't understand. The git-checkout-script already takes a 
> parameter to indicate _what_ to check out. It just defaults to head.
> 
> So you'd do
> 
> 	git-checkout-script branch && switch branch
> 
> and you'd be done.

ah, ok.


> Anyway, I liked the branch semantics for "git checkout" so much that I 
> just made it do that by default. In other words, if you do
[...]
> These seem like sane and useful semantics, and your "switch" script should 
> really fall out as "git checkout -f".

If git-checkout-script switches the .git/HEAD symlink properly, rather 
than updating the symlink target's contents, then my git-switch-tree 
script can just go away :)

Thanks,

	Jeff


