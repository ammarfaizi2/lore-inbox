Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272659AbTG1EvI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 00:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272662AbTG1EvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 00:51:08 -0400
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:35878
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S272659AbTG1EvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 00:51:05 -0400
Message-ID: <3F24B1EE.9080900@rogers.com>
Date: Mon, 28 Jul 2003 01:17:34 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org
Subject: 260test2+O10int breaks : Re: WINE + Galciv + Con Kolivar's 09 patch
 to  2.6.0-test1-mm2
References: <3F22F75D.8090607@rogers.com> <200307271205.59230.kernel@kolivas.org>
In-Reply-To: <200307271205.59230.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.157.78.60] using ID <dw2price@rogers.com> at Mon, 28 Jul 2003 01:06:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update: 260-test2 with O10int has returned wine+galciv to freezing the 
whole computer on starting the game. The intro avi plays less than 1 
second and the machine freezes up. I can swtich from virtual terminals 
but not enter any input.

Con Kolivas wrote:
> On Sun, 27 Jul 2003 07:49, gaxt wrote:
> 
>>Kudos to CK
> 
> 
> Thanks.
> 
> 
>>In 2.4.21 galciv + wine was fine.
>>
>>In 2.4.21 + CK patches, galvic + wine would pause every 15 seconds or so
>>(maybe it was when little animations played).
>>
>>In 2.6.0-test1-mm2 (vanilla, or + 08) Galciv would stutter horribly and
>>freeze my machine in wine. It might run smoothly until I loaded a
>>nautilus window or something then stutters and loss of control of the
>>system.
>>
>>With 09, it is smooth as silk until I do something and then the video
>>playbacks can be choppy but the game (turn based strategy) seems to run
>>without the long pauses of 2.4.21 CK or 2.6.0 vanilla. I can switch
>>between apps and go back without any problem.
>>
>>09 seems to be a big improvement for whatever caused the stutter & die
>>problems in wine+galciv.
> 
> 
> Therein lies the problem with large MAX_SLEEP_AVG values. It may prevent 
> interactive tasks from becoming non interactive (which is the point), but if 
> an interactive task turns into a true cpu hog it can literally stall the 
> machine for seconds. Which is why the workaround in O*int that allow small 
> MSAs help.
> 
> Con
> 
> 


