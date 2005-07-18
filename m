Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVGRFS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVGRFS2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 01:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVGRFS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 01:18:28 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:48534 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261522AbVGRFS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 01:18:27 -0400
Message-ID: <42DB3B59.1080006@google.com>
Date: Sun, 17 Jul 2005 22:17:13 -0700
From: Hareesh Nagarajan <hareesh@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Zanussi <zanussi@us.ibm.com>
CC: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       karim@opersys.com, varap@us.ibm.com, richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
References: <17107.6290.734560.231978@tut.ibm.com>	<20050712022537.GA26128@infradead.org>	<20050711193409.043ecb14.akpm@osdl.org>	<Pine.LNX.4.61.0507131809120.3743@scrub.home>	<17110.32325.532858.79690@tut.ibm.com>	<Pine.LNX.4.61.0507171551390.3728@scrub.home> <17114.32450.420164.971783@tut.ibm.com>
In-Reply-To: <17114.32450.420164.971783@tut.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Zanussi wrote:
> Roman Zippel writes:
>  > Hi,
>  > 
>  > On Thu, 14 Jul 2005, Tom Zanussi wrote:
>  > 
>  > > The netlink control channel seems to work very well, but I can
>  > > certainly change the examples to use something different.  Could you
>  > > suggest something?
>  > 
>  > It just looks like a complicated way to do an ioctl, a control file that 
>  > you can read/write would be a lot simpler and faster.
> 
> You're right - in previous versions, we did use ioctl - we ended up
> using netlink as it seemed like least offensive option to most people.
> I'll try modifying the example code to use a control file or something
> like that instead though.

Having an ioctl() interface will definitely make things less 
complicated. Are the older versions which use ioctl available off the 
relayfs website?

I'm not quite sure if my opinion matters but I'd like to see relayfs 
merged. To me it appears to be the quickest and cleanest way to export 
trace data from the kernel to userspace.

Thanks,

Hareesh Nagarajan
-= Engineering Intern =-
