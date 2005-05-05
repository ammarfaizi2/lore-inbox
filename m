Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVEESQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVEESQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 14:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVEESQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 14:16:55 -0400
Received: from mail.dvmed.net ([216.237.124.58]:19076 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262165AbVEESQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 14:16:53 -0400
Message-ID: <427A630E.5000008@pobox.com>
Date: Thu, 05 May 2005 14:16:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Dave Kleikamp <shaggy@austin.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git pull] jfs update
References: <20050504204744.DA0A0849AD@kleikamp.dyn.webahead.ibm.com> <Pine.LNX.4.58.0505041437060.2328@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505041437060.2328@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 4 May 2005, Dave Kleikamp wrote:
> 
>>I think I've got this set up right.  I have created a HEAD-for-linus and
>>HEAD-for-mm in the same git repo.
> 
> 
> Ok, my scripts don't handle that very well yet (they just want HEAD), but 
> that was easy enough to hack around. I'll be able to work with that 
> format.
> 
> 
>>Please pull from
>>
>>rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git/HEAD-for-linus


FWIW I'm definitely interested in some sort of pull mechanism where I 
can say "pull from foo://.../libata-2.6.git/HEAD-for-linus" also.

With my netdev-2.6 queue, and given git's intrinsic abilities, I am 
planning to keep all ~30 or so mini-branches in a single git tree.  When 
I am ready to push some upstream, I can do a HEAD-for-linus merge tree, 
that merges selected branches.

	Jeff


