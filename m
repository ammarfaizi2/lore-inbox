Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbTDXCQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 22:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264421AbTDXCQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 22:16:10 -0400
Received: from lakemtao03.cox.net ([68.1.17.242]:11995 "EHLO
	lakemtao03.cox.net") by vger.kernel.org with ESMTP id S264419AbTDXCQJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 22:16:09 -0400
Message-ID: <3EA74BB2.7040904@cox.net>
Date: Wed, 23 Apr 2003 21:28:02 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: joe.korty@ccur.com, Nils Holland <nils@ravishing.de>,
       Greg KH <greg@kroah.com>
Subject: Re: [2.4.21-rc1] USB Trackball broken
References: <3EA6C558.5040004@cox.net> <20030423201619.GB12889@kroah.com> <3EA707D2.1000507@cox.net> <200304240034.20872.nils@ravishing.de> <20030424011616.GA11649@tsunami.ccur.com> <3EA74063.5040808@cox.net>
In-Reply-To: <3EA74063.5040808@cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David van Hoose wrote:
> Joe Korty wrote:
> 
>> Hi David, Nils,
>>
>> Nils, you have
>>
>>     CONFIG_USB_HIDINPUT=y
>>
>> which is correct.  David, you have
>>
>>     CONFIG_USB_HIDINPUT=m
>>
>> which is an illegal setting.  You must have hand-edited your config file
>> to get this.  My guess is, the '=m' is being treated as 'not set'.
>>
>> You also need to have CONFIG_INPUT (Input core support section) set.
>> If this is not set you will not see the CONFIG_USB_HIDINPUT question
>> come up in the USB section.
> 
> 
> Actually I didn't.. Blame RedHat. I used their config for the template 
> for my kernel so I'd have fairly good compatibility. I'm compiling a 
> kernel now to see if that was the bug.

This was it! I now have a working trackball! Thanks all of you who 
helped me out. I'll post a bug report to RedHat now. :-)

Thanks!
David

