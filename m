Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVCPFhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVCPFhy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 00:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVCPFhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 00:37:53 -0500
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:35672 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262528AbVCPFhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 00:37:35 -0500
Message-ID: <4237C61A.6040501@sbcglobal.net>
Date: Wed, 16 Mar 2005 00:37:30 -0500
From: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041223
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 USB broken on VIA computer (not just ACPI)
References: <4237A5C1.5030709@sbcglobal.net>	<20050315203914.223771b2.akpm@osdl.org>	<4237C40C.6090903@sbcglobal.net> <20050315213110.75ad9fd5.akpm@osdl.org>
In-Reply-To: <20050315213110.75ad9fd5.akpm@osdl.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suppose you have to have your priorities.  It may be old to you, but 
it's current to me!  That used to be the hallmark of Linux, the fact 
that it would run on lesser hardware.

Of course, I don't know how well video capture is going to work without 
the apic programming.  So I guess I'm reduced to rebooting when I want 
to switch between USB peripherals and video capture?

Maybe I should have lied and said it worked :-)

Andrew Morton wrote:
> "Robert W. Fuller" <orangemagicbus@sbcglobal.net> wrote:
> 
>> I never actually saw it work until I added the noapic option to the 
>> 2.6.11.2 boot.  Now I can usually my USB mouse!  Of course the downside 
>> to specifying noapic is only one CPU is servicing interrupts on my SMP 
>> system.
> 
> 
> Oh, OK.  I was just wondering whether this was an actual regression.  I
> guess as it's an old machine and you have a workaround, we have other
> things to be working on.
> 
> It would be nice to fix though.
> 
> 
>> It certainly doesn't work under 2.4.28, but I haven't tried specifying 
>> noapic to that kernel.  Would that be useful information?
> 
> 
> Probably not.
