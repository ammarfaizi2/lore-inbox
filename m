Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWGPP3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWGPP3l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 11:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWGPP3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 11:29:41 -0400
Received: from main.gmane.org ([80.91.229.2]:3039 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750872AbWGPP3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 11:29:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Lexington Luthor <Lexington.Luthor@gmail.com>
Subject: Re: reiserFS?
Date: Sun, 16 Jul 2006 16:29:24 +0100
Message-ID: <e9dm0p$15s$1@sea.gmane.org>
References: <50d1c22d0607160545rd06c828n55ad9bbbd2f20bfd@mail.gmail.com> <20060716135038.GA8850@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: bb-82-108-13-253.ukonline.co.uk
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
In-Reply-To: <20060716135038.GA8850@merlin.emma.line.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> Why would anyone want ReiserFS in the kernel that is discontinued by its
> developers when it's just started to become stabile and useful, with
> bugs (hashing) remaining, as happened with 3.6? Who is going to make
> guarantees this won't happen again with reiser4?

I looked at the reiser4 patch, and it does very little outside of the 
fs/reiser4 directory. If it is no longer supported by namesys, why can't 
it just be removed from the kernel like all the other bits that are 
obsoleted?

I am just saddened that kernel decisions are motivated by politics and a 
personal dislike of Hans Reiser rather than technical merit. :(

> There's ext3, you can set the dir_index option (either for mke2fs, or
> afterwards with tune2fs, then unmount and run e2fsck -fD) and you're set.

I am not arguing for the inclusion of reiser4 in the kernel, but you 
should know it has its uses. There are very many things that reiser4 can 
do that will make ext3 blow up. It simply the best filesystem for many 
kinds of usage patterns.

Regards,
LL

