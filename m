Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265471AbUBFUm2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 15:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265473AbUBFUm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 15:42:28 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:47261 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265471AbUBFUm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 15:42:27 -0500
Message-ID: <4023FCE5.1020300@myrealbox.com>
Date: Fri, 06 Feb 2004 12:45:25 -0800
From: walt <wa1ter@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; NetBSD i386; en-US; rv:1.6) Gecko/20040118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1] Kernel panic with ppa driver updates
References: <4023D098.1000904@myrealbox.com> <20040206182844.GJ21151@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040206182844.GJ21151@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Fri, Feb 06, 2004 at 09:36:24AM -0800, walt wrote:
> 
>>This panic started with the bk changesets applied by Linus yesterday.
>>
>>The ppa driver works fine when compiled as a module, but when compiled in
...

> Very interesting.  So it works as a module (== finds disks and handles them
> OK) and dies when it's built-in?

Right.


> Could you post the actual oops? ...

The reason I didn't post it is that it has already scrolled off the top of
my console by the time I can read anything :-(   I can see the hex values
for the registers and hex values for the stack trace, but nothing earlier
than that.  I looked in /var/log/messages but I see that kjournald doesn't
start until well after the oops.

I thought about compiling in support for console on serial-or-parallel
port but I've never been clear on just what to plug into the serial-or-
parallel port after I've done that.  Can you give me a hint how I can
get the whole oops message for you?




