Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161103AbWJNLTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbWJNLTT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 07:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbWJNLTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 07:19:19 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:3333 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S1752155AbWJNLTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 07:19:18 -0400
Message-ID: <4530C7B3.6030805@superbug.co.uk>
Date: Sat, 14 Oct 2006 12:19:15 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.7 (X11/20060917)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Driver model.. expel legacy drivers?
References: <4530570B.7030500@comcast.net> <20061014075625.GA30596@stusta.de>
In-Reply-To: <20061014075625.GA30596@stusta.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
>> ...
>> This brings up a few potential questions:
>>
>>   - Will this eventually be necessary to an absolute?  Will 100M
>>     tarballs and hundreds of thousands of drivers be unmanageable in a
>>     tight, ABI-unstable monolith 10 years from now?
> 
> "hundreds of thousands of drivers" won't happen during my lifetime.
> 
> If the kernel size only doubles to 100 MB that's no problem.
> 
>>   - Would it ACTUALLY be worthwhile, given such a scenario, to expel
>>     drivers out of the tree to glue on by a static, somewhat slower but
>>     workable ABI so nobody has to touch the code ever?
> 
> Documentation/stable_api_nonsense.txt describes why this is nonsense.
> 

stable api is even nonsense for Windows, which tries to have a stable
api for drivers. For example, manufacturers are having to write Vista
specific drivers, because their old Windows XP drivers don't work on
Vista. E.g. Creative sound cards.


