Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274439AbRITMHX>; Thu, 20 Sep 2001 08:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274438AbRITMHO>; Thu, 20 Sep 2001 08:07:14 -0400
Received: from mail4.svr.pol.co.uk ([195.92.193.211]:40214 "EHLO
	mail4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S274439AbRITMHA>; Thu, 20 Sep 2001 08:07:00 -0400
Message-ID: <3BA9DBED.9020401@humboldt.co.uk>
Date: Thu, 20 Sep 2001 13:07:09 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4+) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: tegeran@home.com
CC: t.sailer@alumni.ethz.ch, Thomas Sailer <sailer@scs.ch>,
        jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: via82cxxx_audio locking problems
In-Reply-To: <3BA9AB43.C26366BF@scs.ch> <01092004333500.00182@c779218-a>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Knight wrote:

 
> thankyouthankyouthankyouthankyouthankyou
> Adrian Cox was working on this after I raised the issue on the list, but 
> nobody got anywhere. All we knew was that there were temporary lockups 
> appearing when anything was using the mixer.


This is the right answer. The reason some of us didn't see a problem may 
actually be quite simple: we were using very small buffers in xmms. Once 
I increased the xmms buffer size the problem became visible.

-- 
Adrian Cox   http://www.humboldt.co.uk/

