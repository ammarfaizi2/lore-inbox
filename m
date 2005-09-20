Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932663AbVITQo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbVITQo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 12:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbVITQo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 12:44:59 -0400
Received: from mail.portrix.net ([212.202.157.208]:39816 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S932663AbVITQo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 12:44:59 -0400
Message-ID: <43303C85.1020301@ppp0.net>
Date: Tue, 20 Sep 2005 18:44:53 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Thunderbird/1.0.6 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sean <seanlkml@sympatico.ca>
CC: Alexander Nyberg <alexn@telia.com>,
       Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: Arrr! Linux v2.6.14-rc2
References: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org>       <200509201005.49294.gene.heskett@verizon.net>       <20050920141008.GA493@flint.arm.linux.org.uk>       <200509201025.36998.gene.heskett@verizon.net>       <56402.10.10.10.28.1127229646.squirrel@linux1>       <20050920153231.GA2958@localhost.localdomain>    <BAYC1-PASMTP030BBDF3F9B2552DA9CF26AE950@cez.ice>    <43303650.5030202@sfhq.hn.org> <BAYC1-PASMTP033EBAB483DBE4397549B2AE950@cez.ice>
In-Reply-To: <BAYC1-PASMTP033EBAB483DBE4397549B2AE950@cez.ice>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean wrote:
> On Tue, September 20, 2005 12:18 pm, Jan Dittmer said:
> 
>>Sean wrote:
>>
>>>On Tue, September 20, 2005 11:32 am, Alexander Nyberg said:
>>>
>>>
>>>>ketchup <version>
>>>
>>>"git pull" is actually simpler in that you don't need to specify a
>>>version.  And it will keep you current with HEAD even between official
>>>releases.
>>
>>$ ketchup 2.6-git
>>
>>and you've the plus of very well defined checkpoints.
> 
> 
> Huh?  Have you ever used git?  Not only do you get very well defined
> checkpoints you can instantiate a tree down to any specific commit.  And
> you get the plus of a complete detailed changelog etc.. "git log".  
> Really, ketchup doesn't come close to git.

I know, but for multiple people testing daily releases it's much easier to
say -git1 worked -git2 didn't. Sure, for searching the patch `git bisect`
is priceless but for regular testing the -gitx thing comes very handy.
Otherwise you can get a arbitrary intermediate state of linus tree if
you're pulling at the wrong moment. It's actually also faster I suppose
to get one patch than running `git pull` - at least with a cold cache
(it used to be in the 0.1 days of git).
Just my .02,

Jan
