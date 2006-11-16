Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754881AbWKPWvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbWKPWvT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754886AbWKPWvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:51:19 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:38081 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1754881AbWKPWvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:51:18 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <455CEB48.5000906@s5r6.in-berlin.de>
Date: Thu, 16 Nov 2006 23:50:48 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       bcollins@debian.org
Subject: Re: 2.6.19-rc5-mm2
References: <20061114014125.dd315fff.akpm@osdl.org> <20061116171715.GA3645@inferi.kami.home> <455CAE0F.1080502@s5r6.in-berlin.de> <20061116203926.GA3314@inferi.kami.home>
In-Reply-To: <20061116203926.GA3314@inferi.kami.home>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattia Dongili wrote:
> On Thu, Nov 16, 2006 at 07:29:35PM +0100, Stefan Richter wrote:
>> Could you also test one or even better both of:
>>  - 2.6.19-rc5 plus
>> http://me.in-berlin.de/~s5r6/linux1394/updates/2.6.19-rc5/2.6.19-rc5_ieee1394_v204_experimental.patch.bz2
>> (these are the same FireWire drivers as in -rc5-mm2)
> 
> the oops disappear
> 
>> and/ or
>>  - 2.6.19-rc5-mm2 minus
>> http://www.it.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/broken-out/git-ieee1394.patch
> 
> the oops is there again.
> I suppose git-ieee1394 is the one then...

On the contrary, it's very likely _not_ git-ieee1394.

> dmesg:
> http://oioio.altervista.org/linux/2.6.19-rc5-test1-ok
> http://oioio.altervista.org/linux/2.6.19-rc5-mm2-1-ko

I will look at it tomorrow.

> next step (smells like bisection) if for tomorrow :)

Unless you are eager to get results faster, let me think about where
this superfluous node_entry could come from. Perhaps a run-time test of
-mm by myself is in order; I am currently on 2.6.19-rc4 plus that patch
at me.in-berlin.de. Could spare you a lot of time if I find out more. :-)

Thanks for the help,
-- 
Stefan Richter
-=====-=-==- =-== =----
http://arcgraph.de/sr/
