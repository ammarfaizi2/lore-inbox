Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267200AbUBMWFU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267240AbUBMWFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:05:20 -0500
Received: from cpc3-hitc2-5-0-cust51.lutn.cable.ntl.com ([81.99.82.51]:62122
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S267200AbUBMWFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:05:12 -0500
Message-ID: <402D4A18.5090708@reactivated.net>
Date: Fri, 13 Feb 2004 22:05:12 +0000
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is nForce2 good choice under Linux?
References: <Pine.LNX.4.58.0402132048330.31906@alpha.polcom.net> <402D3448.7080105@reactivated.net> <Pine.LNX.4.58.0402132205510.31906@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.58.0402132205510.31906@alpha.polcom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Grzegorz Kulewski wrote:
> You mean that kernel 2.6-mm with this patch with APIC and ACPI enabled 
> works OK? Is this patch a complete fix or a workaround?
Yep, it works fine. The patch is a workaround, I think it disables going into 
C1 disconnect state too early, and refuses to go into C1 disconnect state when 
  we know we will reconnect right afterwards. I'm not too sure on the details 
here, check Ross Dicksons previous posts for clarification.

>>I have been perfectly happy with my NF7-S, except from the one time it failed 
>>on me (didn't boot up), and I had to get it replaced. I think there is a 
>>general risk involved in buying nforce2 boards, their rate of failure is 
>>fairly high. Still, the benefits are nice.
> Wow! This fringtens me! What do you mean? Why are they so failure-able? 
> Are they worse than other new boards in it? Are they, at least, easily, 
> fast and free replaced (under warranty)?

Before I bought this board, I was doing some reading up, as you do. I found 
quite a few cases of people having problems (DOA, bootup trouble, bios not 
saving settings on reboots, etc.). The general word going around at the time 
was that the boards were great, but failures and problems were quite common. 
This was quite a while ago (June-July 2003) so you might want to check around 
for newer opinions. You will probably also discover the word going around 
about the very first AN7s, involving gashes in the board to fix late bugs, and 
hand soldered components.

As for getting replacements, yes, I got a replacement with my supplier, even 
though they said they wouldn't guarantee any returns after 3 months. After I 
purchased the board I discovered that the Abit UK offices are very near me, 
and when I approached them to get it repaired, they refused - they will only 
repair boards that came directly from them. So, check with your supplier 
before you buy, because you probably wont have any luck with Abit directly.

Daniel
