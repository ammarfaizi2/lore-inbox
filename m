Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbTBGPxl>; Fri, 7 Feb 2003 10:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbTBGPxl>; Fri, 7 Feb 2003 10:53:41 -0500
Received: from main.gmane.org ([80.91.224.249]:50619 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S265885AbTBGPxk>;
	Fri, 7 Feb 2003 10:53:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andrew Rodland <arodland@noln.com>
Subject: Re: acpi + keyboard/mouse problems [was Re: acpi + synaptics trackpad in 2.5]
Date: Fri, 07 Feb 2003 10:57:30 -0500
Organization: Dis Organization
Message-ID: <b20ktt$4lb$1@main.gmane.org>
References: <20030203210258.GA17499@triplehelix.org> <20030204233301.GF128@elf.ucw.cz> <20030205150331.GA8582@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan wrote:

> On Wed, Feb 05, 2003 at 12:33:02AM +0100, Pavel Machek wrote:
>> Hi!
>> 
>> > Whenever I run a ACPI battery monitor in X, my mouse goes completely
>> > insane - goes around everywhere, and clicks randomly. the second i
>> > close it, everything returns to normal.
>> 
>> What machine?
> 
> This is a Dell SmartStep 200N. I have no other working laptops using
> ACPI so I can't know for sure how big a problem this is :)

Alright...
I know that some Dells (although I can't say whether yours is one) do their
ACPI by calling back into Dell SMM calls -- which takes the processor away
from linux for a significant amount of time; enough to cause clock
slippage, and loss of mouse data. And I'm guessing an ACPI battery monitor
polls at a fairly short interval, so, it could be related.

Cheers
--hobbs


