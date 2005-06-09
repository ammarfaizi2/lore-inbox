Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVFIGd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVFIGd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 02:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVFIGcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 02:32:09 -0400
Received: from mail.dvmed.net ([216.237.124.58]:32212 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262280AbVFIG3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 02:29:54 -0400
Message-ID: <42A7E1D6.3070509@pobox.com>
Date: Thu, 09 Jun 2005 02:29:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: jketreno@linux.intel.com, vda@ilport.com.ua, pavel@ucw.cz,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw2100: firmware problem
References: <42A7268D.9020402@linux.intel.com>	<20050608.124332.85408883.davem@davemloft.net>	<42A7DC4D.7000008@pobox.com> <20050608.231319.95056824.davem@davemloft.net>
In-Reply-To: <20050608.231319.95056824.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Jeff Garzik <jgarzik@pobox.com>
> Date: Thu, 09 Jun 2005 02:06:05 -0400
> 
> 
>>Therefore, the easiest way to make things work today is to poke Intel to 
>>fix their firmware license so that we can distribute it with the kernel :)
> 
> 
> Seperate firmware from the in-kernel driver is a big headache for
> users.  As DaveJ has stated, people make mistakes and try to match up
> the wrong firmware version with the driver and stuff like that.  And
> he should know as he has to deal sift through bogus bug reports from
> people running into this problem.
> 
> If it's integrated, there are no problems like this.

Early userspace is (a) shipped with the kernel source tree and (b) 
linked into vmlinux.  That's integrated.

The firmware images will be separate from the .c files (as they should 
be), but the kernel hacker still controls what gets loaded, and when.

But like I said, that's where we're going, not where we are now.

	Jeff


