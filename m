Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268696AbUHaPRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268696AbUHaPRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 11:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268693AbUHaPRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 11:17:20 -0400
Received: from mail.tmr.com ([216.238.38.203]:262 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268717AbUHaPP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 11:15:57 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Driver retries disk errors.
Date: Tue, 31 Aug 2004 11:16:47 -0400
Organization: TMR Associates, Inc
Message-ID: <ch24b2$8kk$1@gatekeeper.tmr.com>
References: <20040830174632.GA21419@thunk.org><20040830174632.GA21419@thunk.org> <41337153.60505@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1093964962 8852 192.168.12.100 (31 Aug 2004 15:09:22 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <41337153.60505@superbug.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:

> It does the same retries with CD-ROM and DVDs, and if the retries fail, 
> it disables DMA! It even does the retries when reading CD-Audio.
> Maybe there should be a "retrys" setting that can be set by hdparm, then 
> we could set the retry counts, and what happens when a retry fails on a 
> per device basis.

Thinking hotswap, I could suggest that "device category" would be useful 
for this. Yes, you could build policy into the plug code, but it still 
needs to get the policy from somewhere.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
