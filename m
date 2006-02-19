Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWBSXwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWBSXwA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWBSXwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:52:00 -0500
Received: from lucidpixels.com ([66.45.37.187]:10690 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932452AbWBSXv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:51:58 -0500
Date: Sun, 19 Feb 2006 18:51:57 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Lee Revell <rlrevell@joe-job.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Intel CSA Gigabit Bug in IC7-G Motherboards- Affects Windows/Linux
In-Reply-To: <1140392860.2733.433.camel@mindpipe>
Message-ID: <Pine.LNX.4.64.0602191848230.7212@p34>
References: <Pine.LNX.4.64.0602191807001.7212@p34> <1140392860.2733.433.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Essentially, when you copy large amounts of data across the NIC it will 
"freeze" the box in Linux (any 2.6.x kernel, have not tried 2.4.x) or 
Windows XP SP2.

If you checkout the thread, it occurs for multiple people under various 
OS' but in *some* cases if they use ABIT's IC7-G CSA/INTEL driver, they 
their problems go away.

In Linux when I used to use the onboard NIC, it froze the box, I did not 
have sysrq enabled at the time when this happened but frozen I mean screen 
is frozen, no ping, box is inoperative.

Nothing pecuilar was ever found in any of the logs or dmesg output 
regarding the crash.

Basically its the first revision of CSA gigabit on a motherboard from what 
I read in the forums and unless you use ABIT's specially crafted driver, 
it will crash the machine when you copy either:

a) large amounts of data over a gigabit link
or
b) that death.zip file (unzipped of course) which contains the bad "bits" 
that are probably seen/repeated when copying large amounts of data

Justin.

On Sun, 19 Feb 2006, Lee Revell wrote:

> On Sun, 2006-02-19 at 18:17 -0500, Justin Piszcz wrote:
>>
>> The author has a "death.zip" file, in which if you copy the file over
>> the
>> LAN it causes an instant crash.
>
> Windows and Linux?  What kind of "crash"?  An Oops?  Lockup?  Reboot?
> Anything in the logs?
>
> Your report is way too vague to be actionable.
>
> Lee
>
