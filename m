Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWFTI1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWFTI1b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWFTI1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:27:31 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:60614 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932166AbWFTI1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:27:30 -0400
Message-ID: <4497B16E.6020103@garzik.org>
Date: Tue, 20 Jun 2006 04:27:26 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: discuss@x86-64.org, Dave Olson <olson@unixfolk.com>,
       Brice Goglin <brice@myri.com>, linux-kernel@vger.kernel.org,
       Greg Lindahl <greg.lindahl@qlogic.com>, gregkh@suse.de
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check
 Hyper-transport capabilities
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no> <200606200925.30926.ak@suse.de> <4497ABAC.4030305@garzik.org> <200606201013.51564.ak@suse.de>
In-Reply-To: <200606201013.51564.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 20 June 2006 10:02, Jeff Garzik wrote:
>> Andi Kleen wrote:
>>> So if there are any more MSI problems comming up IMHO it should be white list/disabled 
>>> by default and only turn on after a long time when Windows uses it by default 
>>> or something. Greg, do you agree?
>>
>> We should be optimists, not pessimists.
> 
> Yes, booting on all systems is overrated anyways, isn't it?

Don't be silly.  Whatever solution is arrived at will boot on all 
systems.  That's an obvious operational requirement.

This is how new technology always works in Linux.  We turn it on and see 
what works, and what doesn't.  And whether existing problems will 
disappear.  With MSI, I think we see them disappearing.

Newer systems seem to be doing better with MSI, in part because 
PCI-Express and other technologies trend towards MSI-style operation.

And the kernel's MSI code is finally getting cleaned up, and getting the 
attention it needs.


>> MSI is useful enough that we should turn it on by default in newer systems.
> 
> That is what we've tried so far and it seems to not work.

IMO that's an exaggeration.  On 50% of the x86-64 platforms (Intel), MSI 
has been working for quite some time.  On newer systems in the other 
half of the platforms, MSI seems be more usable than it has been in the 
past.

	Jeff


