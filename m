Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265385AbTL2Ucf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 15:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265390AbTL2Ucf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 15:32:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49283 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265385AbTL2Uca
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 15:32:30 -0500
Message-ID: <3FF08F48.4020506@pobox.com>
Date: Mon, 29 Dec 2003 15:32:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [CFT/PATCH] give sound/oss/trident a holiday cleanup for 2.6
References: <20031229183846.GI13481@actcom.co.il> <Pine.LNX.4.58.0312291049020.2113@home.osdl.org> <20031229185627.GJ13481@actcom.co.il> <3FF07BF3.2090500@pobox.com> <Pine.LNX.4.58.0312291137021.2113@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312291137021.2113@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 29 Dec 2003, Jeff Garzik wrote:
> 
>>Thirty separate patches is OK.
>>
>>We have scripts to handle "patchbombs".
> 
> 
> Yes and no.
> 
> Thirty separate patches make sense if they are independent and really do 
> conceptually different things. Then it makes sense to have them as 
> separate checkins, and be able to tell people "ok, try undoing that one, 
> maybe that's the problem".
> 
> However, if they are all just "fix silly bugs in xxx", then I'd much 
> rather see it as one big patch. Having it split up into "fix bug on line 
> 50" and "fix bug on line 75" just doesn't make any sense - it only makes 
> the patch history harder to follow.


There's certainly a middle ground.  For drivers I generally request that 
bug fixes for separate bugs be split up, since inevitably one bug fix 
out of twenty breaks for somebody on that somebody's weird hardware.

	Jeff



