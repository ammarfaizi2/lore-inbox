Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262814AbVFVJV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbVFVJV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbVFVHoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:44:21 -0400
Received: from mail.dvmed.net ([216.237.124.58]:21675 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262833AbVFVFvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:51:52 -0400
Message-ID: <42B8FC74.8040306@pobox.com>
Date: Wed, 22 Jun 2005 01:51:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: git-pull-script on my linus tree fails..
References: <Pine.LNX.4.58.0506211304320.2915@skynet> <Pine.LNX.4.58.0506210837020.2268@ppc970.osdl.org> <42B838BC.8090601@pobox.com> <Pine.LNX.4.58.0506210905560.2268@ppc970.osdl.org> <42B84E20.7010100@pobox.com> <Pine.LNX.4.58.0506211039350.2268@ppc970.osdl.org> <42B8542A.9020700@pobox.com> <Pine.LNX.4.58.0506211103370.2268@ppc970.osdl.org> <42B859B4.5060209@pobox.com> <Pine.LNX.4.58.0506211124310.2268@ppc970.osdl.org> <42B8A82E.4020207@pobox.com> <42B8A8CA.9040804@pobox.com> <Pine.LNX.4.58.0506211709220.2353@ppc970.osdl.org> <42B8B4C8.70704@pobox.com> <Pine.LNX.4.58.0506211810170.2353@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506211810170.2353@ppc970.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> And hey, if you don't like the feature, you can always just use the "-f"  
> flag, which will act the way your old script did, and always just throw
> any pending changes away when you check out a new branch.

hehe, that's what I am doing ;-)

For fast-forward merges, I use "git checkout".  For everything else in 
my workflow, I use "git checkout -f $branch"

I'm not sure that I, personally, will ever use "git checkout $branch" 
without "-f".

	Jeff


