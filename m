Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWJASpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWJASpe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 14:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWJASpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 14:45:34 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:44689 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932164AbWJASpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 14:45:33 -0400
Message-ID: <45200CC8.2030404@garzik.org>
Date: Sun, 01 Oct 2006 14:45:28 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Announce: gcc bogus warning repository
References: <451FC657.6090603@garzik.org>	 <1159717214.24767.3.camel@c-67-180-230-165.hsd1.ca.comcast.net>	 <20061001111226.3e14133f.akpm@osdl.org>  <452005E7.5030705@garzik.org> <1159727188.24767.9.camel@c-67-180-230-165.hsd1.ca.comcast.net>
In-Reply-To: <1159727188.24767.9.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Sun, 2006-10-01 at 14:16 -0400, Jeff Garzik wrote:
>> Andrew Morton wrote:
>>> The downsides are that it muckies up the source a little and introduces a
>>> very small risk that real use-uninitialised bugs will be hidden.  But I
>>> believe the benefit outweighs those disadvantages.
>> How about just marking the ones I've already done in #gccbug?
>>
>> If I'm taking the time to audit the code, and separate out bogosities 
>> from real bugs, it would be nice not to see that effort wasted.
> 
> There was a long thread on this, it's not about anyone not reviewing the
> code properly when the warning is first silenced. It's that future
> changes might create new problems that are also silenced. I don't think
> it's a huge concern, especially since there's was a config option to
> turn the warning backs on.

That doesn't address my question at all.

If there is no difference between real non-init bugs and bogus warnings, 
then a config option doesn't make any difference at all, does it?  Real 
bugs are still hidden either way:  if the warnings are turned on, the 
bugs are lost in the noise.  if the warnings are turned off, the bugs 
are completely hidden.

	Jeff



