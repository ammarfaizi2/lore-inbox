Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbTJZJNm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 04:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbTJZJNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 04:13:42 -0500
Received: from [134.29.1.12] ([134.29.1.12]:18055 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S262536AbTJZJNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 04:13:41 -0500
Message-ID: <3F9B9032.8090804@hundstad.net>
Date: Sun, 26 Oct 2003 03:13:22 -0600
From: "Jeffrey E. Hundstad" <jeffrey@hundstad.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [long] linux-2.6.0-test9, XFree86 4.2.1.1, ATI ATI Radeon VE
 QY, screen hangs on 3d apps
References: <3F9B8A6B.6030102@hundstad.net> <3F9B9BEB.5060908@cyberone.com.au>
In-Reply-To: <3F9B9BEB.5060908@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
>
> Jeffrey E. Hundstad wrote:
>
>> Hello,
>>
>> I'm using Debian unstable.  It comes with XFree86 Vesrion 4.2.1.1.  
>> This works fine with linux-2.4.22.  I've been using this 
>> configuration with accelerated 3d apps.  With linux-2.6.0-test9 X 
>> works fine until a 3d application such as glxgears starts.  The 
>> screen no longer updates except that you can move the cursor.  The 
>> logs do not indicate failure.  I can't get the screen back without a 
>> reboot.  I can connect via. the network to do analysis if someone 
>> wants to give me a clue what to look for.
>
>
>
> renice 0 `pidof X`
>
> How does it go with X at default priority?
>

The priority was set at -10.

After setting the priority to 0 as you suggest nothing changes.

$glxgears

frame appears,
screen hangs.
I can move the cursor around, but this gets boring fast ;-)

