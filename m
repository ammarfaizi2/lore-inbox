Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266493AbUG0To3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266493AbUG0To3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUG0To3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:44:29 -0400
Received: from mail.tmr.com ([216.238.38.203]:65035 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266493AbUG0To1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:44:27 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] Delete cryptoloop
Date: Tue, 27 Jul 2004 15:47:22 -0400
Organization: TMR Associates, Inc
Message-ID: <ce6b0e$hu5$2@gatekeeper.tmr.com>
References: <2kECW-3a0-7@gated-at.bofh.it><2kECW-3a0-7@gated-at.bofh.it> <E1BnzGM-0005zX-00@gimli.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1090957134 18373 192.168.12.100 (27 Jul 2004 19:38:54 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <E1BnzGM-0005zX-00@gimli.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Walter Hofmann wrote:
> You wrote on linux.kernel:
> 
>>dpf-lkml@fountainbay.com wrote:
>>
>>>Hopefully someone else will follow up, but I hope I'm somewhat convincing:
>>
>>Not really ;)
>>
>>Your points can be simplified to "I don't use cryptoloop, but someone else
>>might" and "we shouldn't do this in a stable kernel".
>>
>>Well, I want to hear from "someone else".  If removing cryptoloop will
>>irritate five people, well, sorry.  If it's 5,000 people, well maybe not.
> 
> 
> I use cryptoloop and I would be really annoyed if it disappeared in
> the stable kernel series. Besides, I read in another mail in this thread 
> that dm-crypt will not work with file-based storage (I'm using 
> cryptoloop on a file), and that it is new and potentially buggy.
> 
> I'm really surprised that people here argue that dm-crypt doesn't get 
> enough testing so cryptoloop has to go to force people to test dm-crypt 
> with their valuable data. This is all upside-down. First dm-crypt has to 
> be stable, safe and feature-complete, then people can convert their data 
> to dm-crypt and only then can cryptoloop be deleted.

Not to mention working with mount... That would be good if we didn't 
have to train people, change scripts, etc.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
