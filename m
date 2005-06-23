Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVFWAHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVFWAHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVFWAGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:06:49 -0400
Received: from mail.dvmed.net ([216.237.124.58]:15537 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261843AbVFWAFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:05:09 -0400
Message-ID: <42B9FCAE.1000607@pobox.com>
Date: Wed, 22 Jun 2005 20:05:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com> <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 22 Jun 2005, Greg KH wrote:
> 
>>Ok, this is annoying.  Is there some reason why git doesn't pull the
>>tags in properly when doing a merge?  Chris and I just hit this when I
>>pulled his 2.6.12.1 tree and and was wondering where the tag went.
> 
> 
> Tags are private in git (the same way branches are), which means that you
> can have a million of your own tags and never disturb anybody else.
> 
> But, like branches, it means that if you want a tag, you need to know the 
> tag you want, and download it the same way you download a branch.

Still -- that's interesting data that no script currently tracks.  You 
gotta fall back to rsync.

	Jeff


