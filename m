Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVCAPtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVCAPtl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 10:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVCAPrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 10:47:12 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:22460 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261952AbVCAPqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 10:46:13 -0500
Message-ID: <42248DE0.9090003@andrew.cmu.edu>
Date: Tue, 01 Mar 2005 10:44:32 -0500
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
CC: Bill Davidsen <davidsen@tmr.com>, Gerd Knorr <kraxel@bytesex.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Potentially dead bttv cards from 2.6.10
References: <20050228134410.GA7499@bytesex><20050228134410.GA7499@bytesex> <42232DFC.6090000@andrew.cmu.edu> <4223A5C3.6010000@tmr.com> <42241491.2060303@andrew.cmu.edu> <42247822.7030107@grupopie.com>
In-Reply-To: <42247822.7030107@grupopie.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I wasn't clear in the previous email; I did try the card= option 
anyway.  I wrote a looping script and tested first 70 card= options, and 
none worked properly for streaming capture.  Some did show different 
behavior though.  I might try the remaining 50 later today.

I did notice one strange thing though; the card= option is only applied 
to the first bttv card.  All remaining cards in the system are still 
autodetected (which ends up assuming card=0 in my case).  Not sure if 
this is the intended behavior or not, since someone really could run two 
different bttv cards in the same system.

  - Jim Bruce

Paulo Marques wrote:
> James Bruce wrote:
> 
>> [...]
>> The card= option didn't help in my case since my card is not in the 
>> list; For thess cards we went off the reccomendation of other people 
>> doing machine vision in Linux; Next time I guess we'll go name brand 
>> again...
> 
> 
> I think you should try it anyway, using all the options, because it is 
> very likely that your card might be compatible with one of the listed 
> ones. This is specially true if you don't care about the tuner.
> 
> Just modprobe the bttv module with card=X option, test it, rmmod it, 
> modprobe it again with card=X+1, etc., until you find a number that fits.
