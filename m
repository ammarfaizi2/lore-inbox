Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266396AbUAOBO3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266390AbUAOBO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:14:28 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24327 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S266389AbUAOBOT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:14:19 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] mm/slab.c remove impossible <0 check - size_t is not
   signed - patch is against 2.6.1-rc1-mm2
Date: Wed, 14 Jan 2004 20:13:16 -0500
Organization: TMR Associates, Inc
Message-ID: <bu4oqc$2dl$2@gatekeeper.tmr.com>
References: <20040108021658.0a8aaccc.pj@sgi.com> <1073576236.2340.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1074128524 2485 192.168.12.10 (15 Jan 2004 01:02:04 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <1073576236.2340.34.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches wrote:
> On Thu, 2004-01-08 at 02:16, Paul Jackson wrote:
> 
>>Jason asked:
>>
>>>Well, anything wrong in cleaning them [unsigned compare warnings] up?
> 
> 
> In this case the warning is not unsigned compare but
> "comparison of .* is always [true|false]".
> 
> This sort of code generally makes me think someone did something wrong,
> not just that the person added additional unnecessary checking.

Agreed, often muddy thinking.


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
