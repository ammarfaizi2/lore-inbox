Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVAUHC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVAUHC5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbVAUHC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:02:57 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:17127 "EHLO
	webhosting.rdsbv.ro") by vger.kernel.org with ESMTP id S262291AbVAUHCn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:02:43 -0500
Date: Fri, 21 Jan 2005 08:58:44 +0200 (EET)
From: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
X-X-Sender: util@webhosting.rdsbv.ro
To: Andi Kleen <ak@suse.de>
cc: Adrian Bunk <bunk@stusta.de>,
       Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
       linux-kernel@vger.kernel.org, Chris Bruner <cryst@golden.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: COMMAND_LINE_SIZE increasing in 2.6.11-rc1-bk6
In-Reply-To: <20050120164829.GG450@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0501210857170.17260@webhosting.rdsbv.ro>
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org>
 <20050120162807.GA3174@stusta.de> <20050120164829.GG450@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2005, Andi Kleen wrote:

>> AOL:
>> - lilo 22.6.1
>> - CONFIG_EDD=y
>> - 2.6.10-mm1 and 2.6.11-rc1 did boot
>> - 2.6.11-rc1-mm1 and 2.6.11-rc1-mm2 didn't boot
>> - 2.6.11-rc1-mm2 with this ChangeSet reverted boots.
>
> What I gather so far the problem seems to only happen with lilo
> and EDID together.  grub appears to work.  Or did anyone
> see problems with grub too?
>
> I'll dig a bit, but reverting for now is probably best.
> Thanks Linus.

I really suggest to push this limit to 4k. My reason is that under UML I 
need to put a lot of stuff in command line and uml crash if I not extend 
this limit. Can we make it depend on arhitecture?

Thanks.
---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
