Return-Path: <linux-kernel-owner+w=401wt.eu-S1751911AbWLNCJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbWLNCJG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 21:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbWLNCJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 21:09:06 -0500
Received: from pumpkin.explorerforum.com ([209.209.36.42]:43676 "EHLO
	pumpkin.explorerforum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbWLNCJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 21:09:05 -0500
X-Greylist: delayed 2558 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 21:09:05 EST
Message-ID: <4580A827.7080200@nersc.gov>
Date: Wed, 13 Dec 2006 17:25:59 -0800
From: Thomas Davis <tdavis@nersc.gov>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@ines.ro>
CC: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: Postgrey experiment at VGER
References: <20061212235056.GP10054@mea-ext.zmailer.org> <1166001902.15211.4.camel@DustPuppy.LNX.RO>
In-Reply-To: <1166001902.15211.4.camel@DustPuppy.LNX.RO>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (pumpkin.explorerforum.com [209.209.36.42]); Wed, 13 Dec 2006 17:26:04 -0800 (PST)
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dumitru Ciobarcianu wrote:
> On Wed, 2006-12-13 at 01:50 +0200, Matti Aarnio wrote:
>> I do already see spammers smart enough to retry addresses from
>> the zombie machine, but that share is now below 10% of all emails.
>> My prediction for next 200 days is that most spammers get the clue,
>> but it gives us perhaps 3 months of less leaked junk.
> 
> IMHO this is only an step in an "arms race".
> What you will do in three months, remove this check because it will
> prove useless since the spammers will also retry ? If yes, why install
> it in the first place ? 
> 
> 

spammers are already re-trying; but they give up after 10 minutes. 
As the delay time increases, the chances of getting on a blacklist 
increase, which makes it easier to identify a machine as a spamming bot.

I normally let my greyfilters run at 30 minutes deny, and 72hrs of 
lease time on a IP/To/From tuplet.  This setting seams to be pretty 
effective in dropping spam; at one point, upto 10k spam vs. a couple 
hundred ham messages.

thomsa
