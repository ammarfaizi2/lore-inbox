Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWGDCCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWGDCCz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 22:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWGDCCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 22:02:54 -0400
Received: from terminus.zytor.com ([192.83.249.54]:26861 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751357AbWGDCCy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 22:02:54 -0400
Message-ID: <44A9CC19.30602@zytor.com>
Date: Mon, 03 Jul 2006 19:02:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jeff Bailey <jbailey@ubuntu.com>
CC: maximilian attems <maks@sternwelten.at>, Rob Landley <rob@landley.net>,
       klibc@zytor.com, Jeff Garzik <jeff@garzik.org>,
       Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, torvalds@osdl.org
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <44A16E9C.70000@zytor.com> <Pine.LNX.4.64.0606290156590.17704@scrub.home> <200607031430.47296.rob@landley.net> <20060703184647.GA14100@baikonur.stro.at> <1151976993.2547.27.camel@localhost.localdomain>
In-Reply-To: <1151976993.2547.27.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Bailey wrote:
> Le lundi 03 juillet 2006 à 20:46 +0200, maximilian attems a écrit :
>> well but busybox is big nowadays and generally compiled against glibc.
>> i'm quite eager to kick busybox out of default Debian initramfs-tools
>> to have an klibc only default initramfs. those tools are needed atm,
>> and there is not enough yet. afaik suse adds sed on klibc with a minimal
>> patch and we'd liked to have stat, kill and readlink on klibc-utils.
>>
>> how about busybox on klibc?
> 
> I made a brief attempt to do busybox on klibc before klcc was working
> right for me.  I should try that again.  In Ubuntu, we already do a
> separate build pass of busybox to get just the features that we want, it
> would be easy to play with this.
> 
> I'll let you know.  It'll take me a couple days - between travelling and
> the long weekend, I'm a bit behind.
> 

I think the main things that aren't in klibc are the userid and the 
network databases.  They should be reasonably easy to stub out.

	-hpa
