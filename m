Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbVCDAo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbVCDAo0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbVCDAk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:40:29 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:51586 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262741AbVCDAiC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:38:02 -0500
Message-ID: <4227ADE7.3080100@drzeus.cx>
Date: Fri, 04 Mar 2005 01:37:59 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mark Canter <marcus@vfxcomputing.com>, rlrevell@joe-job.com,
       nish.aravamudan@gmail.com, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
References: <4227085C.7060104@drzeus.cx>	<29495f1d05030309455a990c5b@mail.gmail.com>	<Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>	<1109875926.2908.26.camel@mindpipe>	<Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>	<1109876978.2908.31.camel@mindpipe>	<Pine.LNX.4.62.0503031527550.30702@krusty.vfxcomputing.com> <20050303154929.1abd0a62.akpm@osdl.org>
In-Reply-To: <20050303154929.1abd0a62.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Mark Canter <marcus@vfxcomputing.com> wrote:
>  
>
>>To close this issue out of the LKML and alsa-devel, a bug report has been 
>>written.
>>
>>It appears to be an issue with the 'headphone jack sense' (as kde labels 
>>it).  The issue is in the way the 8x0 addresses the docking station/port 
>>replicator's audio output jack.  The mentioned quick fix does not work for 
>>using the ds/pr audio output, but does resolve it for a user that is only 
>>using headphones/internal speakers.
>>    
>>
>
>But there was a behavioural change: applications which worked in 2.6.10
>don't work in 2.6.11, is that correct?
>
>If so, the best course of action is to change the kernel so those
>applications work again.  Can that be done?
>
>  
>
Yes. Speakers worked in 2.6.10 and stopped working in 2.6.11. This could 
be changed by setting the default for the two new volumes to muted. I 
don't know how this affects the issue with the docking station or the 
bug that this is supposed to solve though.

Rgds
Pierre

