Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265406AbTL2Ui6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbTL2Uie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:38:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53379 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265403AbTL2Uge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:36:34 -0500
Message-ID: <3FF0903F.1030604@pobox.com>
Date: Mon, 29 Dec 2003 15:36:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Wim Van Sebroeck <wim@iguana.be>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] 2.6.0 - Watchdog patches
References: <20030906125136.A9266@infomag.infomag.iguana.be> <20031229205246.A32604@infomag.infomag.iguana.be> <Pine.LNX.4.58.0312291209150.2113@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312291209150.2113@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 29 Dec 2003, Wim Van Sebroeck wrote:
> 
>>Hi Linus, Andrew,
>>
>>please do a
>>
>>	bk pull http://linux-watchdog.bkbits.net/linux-2.5-watchdog
> 
> 
> This tree has 38 deltas, all just merges.
> 
> The end result is a horribly messy revision tree, for a few one-liners.
> 
> I'm going to take the patch as a patch instead, and hope that you'll throw 
> your BK tree away.
> 
> Please don't follow the release tree in your development trees, it makes 
> it impossible to see how the revision history happened.


Agreed.  Several BK developers do this, forgetting that one of things 
that makes BK so useful is its merge technology.

I recommend (assuming no patches outstanding),

* clone latest tree
* do development
* only 'bk pull' from latest tree iff (a) you are about to submit to 
Linus/Andrew or (b) you know there is a conflicting change in upstream

Pulling the latest, just to be up-to-date, just obfuscates things and 
needlessly increases the size of the master ChangeSet file.

	Jeff



