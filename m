Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261424AbSJCXMo>; Thu, 3 Oct 2002 19:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261422AbSJCXMn>; Thu, 3 Oct 2002 19:12:43 -0400
Received: from zeus.kernel.org ([204.152.189.113]:25821 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261424AbSJCXMm>;
	Thu, 3 Oct 2002 19:12:42 -0400
Message-ID: <3D9CCD11.3020506@pobox.com>
Date: Thu, 03 Oct 2002 19:04:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jaroslav Kysela <perex@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA fixes #1
References: <Pine.LNX.4.33.0210031241280.23619-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Thu, 3 Oct 2002, Jaroslav Kysela wrote:
> 
>>>Note that BK really only helps if you are careful, and I can synchronize 
>>>with your BK tree. The fact that your BK tree contains non-alsa stuff 
>>
>>Please, remove the bksend script from Documentation/BK-usage/bksend . 
>>You don't like it and it's completely crappy. BK does renumbering of 
>>ChangeSets itselves. So everybody has different numbers for changesets.

The bksend script works just fine, provided you use it correctly...

I think the main use of the script is not merging with Linus but posting 
public, reviewable BK patches.


> But if there is a clean tree to pull from, that is absolutely the 
> preferred method for me to sync up, _especially_ with things like drivers. 
> Then an email that just says
> 
> 	Linus,
> 	  please do
> 
> 		bk pull .....
> 
> 	to receive changes to the following files
> 
> 	.. diffstat list ..
> 
> 	through the following changes
> 
> 	 .. changset list ..
> 
> and then I don't even need to see the diffs themselves if I can just see
> that it only touches the ALSA files (that's another reason why I really
> want clean trees - immediately that there is a changeset to a non-ALSA
> file I want to see diffs, so that I have a clue about potential conflicts)


And "Documentation/BK-usage/bk-make-sum ~/repo/linus-2.5" helpfully 
generates this output  ;-)

	Jeff



