Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWHRCiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWHRCiz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 22:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbWHRCiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 22:38:55 -0400
Received: from mxsf15.cluster1.charter.net ([209.225.28.215]:20928 "EHLO
	mxsf15.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932319AbWHRCiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 22:38:54 -0400
Message-ID: <44E5283A.8050902@charter.net>
Date: Thu, 17 Aug 2006 21:38:50 -0500
From: Bob Reinkemeyer <bigbob73@charter.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [bug] Mouse jumps randomly in x kernel 2.6.18
References: <44E37FD1.6020506@charter.net> <d120d5000608171138p41b41ce2w38d62117f1817bd0@mail.gmail.com>
In-Reply-To: <d120d5000608171138p41b41ce2w38d62117f1817bd0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dmitry Torokhov wrote:
> On 8/16/06, Bob Reinkemeyer <bigbob73@charter.net> wrote:
>> I have an issue where my mouse jumps around the screen randomly in X
>> only.  It works correctly in a vnc window.  The mouse is a Microsoft
>> wireless optical intellimouse.  This was tested in 2.6.18-rc1-rc4 and
>> observed in all. my config for .18 can be found here...
>> http://rafb.net/paste/results/5cyWFd48.html
>>
>> and for .17 here...
>> http://rafb.net/paste/results/xdFUkU58.html
>>
> 
> Does it help if you revert this patch:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=b0c9ad8e0ff154f8c4730b8c4383f49b846c97c4 
> 
> 

that fixed it.  Thanks!
