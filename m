Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271696AbTG2Mh0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 08:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271698AbTG2MhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 08:37:25 -0400
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:54648
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S271696AbTG2MhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 08:37:23 -0400
Message-ID: <3F266D33.4040106@rogers.com>
Date: Tue, 29 Jul 2003 08:48:51 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: WINE + Galciv + Con Kolivas's 011 patch to  2.6.0-test2
References: <3F22F75D.8090607@rogers.com> <200307290739.04993.kernel@kolivas.org> <3F25DC33.8080908@rogers.com> <200307291325.09096.kernel@kolivas.org>
In-Reply-To: <200307291325.09096.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [65.49.219.239] using ID <dw2price@rogers.com> at Tue, 29 Jul 2003 08:37:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried O11. Still chuggy in the AVIs and then locks out input into X. I 
switch to Alt-F1 console and hear the video advance, switch back, it 
pauses, switch to Alt-F1 etc. to get it through the video and then it's 
fine.

Incidentally, I moved my /home to another hard drive last night (same 
7200 rpms) to get more space. It makes no difference to performance. 
260-test2-vanilla was quite good and -mm1 and -O11 are chuggy and lock 
out input to X and require switching to virtual console to advance 
through the videos.

If there is some other data I can provide you, let me know.

Con Kolivas wrote:
> On Tue, 29 Jul 2003 12:30, gaxt wrote:
> 
>>Con Kolivas wrote:
>>
>>>File I/O ? Try booting with elevator=deadline
>>
>>Setting elevator=deadline results in wine+galciv loading without the
>>horrible long pauses but there is still chugging and while the AVIs
>>play, the rest of Gnome is unresponsive (ie can't switch windows by
>>clicking etc) though I can switch to Alt-F1 virtual terminal. Still not
>>as good as 260-test-2-vanilla
> 
> 
> Well that is weird, but no doubt IO is playing some part here. Can you please 
> try the preview O11 patch (incremental against 2.6.0-test2-mm1 but should 
> patch against an O10 patched vanilla) in 
> 
> http://kernel.kolivas.org/2.5/experimental
> 
> While not specifically addressing this problem, it may help.
> 
> Con
> 
> 


