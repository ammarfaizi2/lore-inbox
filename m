Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbVIHXbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbVIHXbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 19:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVIHXbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 19:31:20 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:52906 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S965078AbVIHXbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 19:31:19 -0400
Message-ID: <41299.192.168.0.13.1126222263.squirrel@192.168.0.2>
In-Reply-To: <1126015886.8338.147.camel@localhost.localdomain>
References: <20050726063043.GI8684@elf.ucw.cz> 
    <20050904113351.B30509@flint.arm.linux.org.uk>
    <1126015886.8338.147.camel@localhost.localdomain>
Date: Thu, 8 Sep 2005 18:31:03 -0500 (CDT)
Subject: Re: [patch] Fix compilation in locomo.c
From: "John Lenz" <lenz@cs.wisc.edu>
To: "Richard Purdie" <rpurdie@rpsys.net>
Cc: "Russell King" <rmk+lkml@arm.linux.org.uk>, "Pavel Machek" <pavel@suse.cz>,
       "kernel list" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, September 6, 2005 9:11 am, Richard Purdie said:
> On Sun, 2005-09-04 at 11:33 +0100, Russell King wrote:
>> On Tue, Jul 26, 2005 at 08:30:43AM +0200, Pavel Machek wrote:
>> > Do not access children in struct device directly, use
>> > device_for_each_child helper instead. It fixes compilation.
>> >
>> > Signed-off-by: Pavel Machek <pavel@suse.cz>
>>
>> Given up waiting for John/Richard to okay this, applied anyway.
>
> You did get a response from me on 20/8/05 which said:
>
> "Locomo is outside my area of expertise and its not present on the
> devices I use/maintain, hence this is something John would have the
> definitive opinion on. The patch looks sane to me though."
>
> I suspect John is between email addresses at the moment. Hopefully he'll
> be back with us soon.

Yeah... I'm now back but haven't yet had a chance to look at any patches
or anything that has been floating around.  Next week I will look closer
at these patches (even if they have already been applied).

John

