Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbTEGN41 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 09:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbTEGN41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 09:56:27 -0400
Received: from mailsrv1-tu0.sanger.ac.uk ([193.62.206.128]:26894 "EHLO
	mailsrv1.sanger.ac.uk") by vger.kernel.org with ESMTP
	id S263200AbTEGN4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 09:56:25 -0400
Message-ID: <3EB9137A.8050806@thekelleys.org.uk>
Date: Wed, 07 May 2003 15:08:58 +0100
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.2.1) Gecko/20030121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Binary firmware in the kernel - licensing issues.
References: <200305071159.h47BxBe04974@adam.yggdrasil.com>
In-Reply-To: <200305071159.h47BxBe04974@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> Simon Kelley wrote:
> 
>>Now Linus could say "I consider that the kernel copyright holders 
>>did/didn't give permission to combine  their work with firmware blobs" 
>>and I contend that practically all the copyright holders would go along
>>with that judgement, just as they went along with Linus's judgement
>>about linking binary-only modules with their work.
> 
> 
> 	I am not a lawyer.  So, please do not rely on this as legal advice.
> 
> 	I think you are confusing people having a strong distaste
> for suing their fellow developers with people agreeing to something.
> Also, your theory would require explicit unanimous agreement of the
> contributors of GPL'ed kernel code if you actually want to guarantee
> anything.
> 

If many copyright holders don't agree then clearly firmware blobs
shouldn't go into the kernel. It is difficult to argue that just one is
enough for a veto, especially since at least one driver (Advansys) has
been there, complete with its "bucket of bits" since 1.3.x days at 
least. Any contributor to the kernel since then who cared could have 
been aware of that as evidence of a de-facto interpretation of the GPL
source clause as not applying to firmware in Linux.

> 	By the way, there are some additional advantages to not compiling
> in the firmware that perhaps you might not have contemplated.  Reducing
> people's perceived legal exposure would most likely help adoption of
> your driver.  Separate firmware loading also offers more upgradability
> and, therefore, maintainability and perhaps extensibility if people
> want to try firmware improvements (for example the WiFi frequencies
> available for use are different in different countries and there may
> also be different power limits or other requirements).  Finally, you
> would avoid the need to keep a copy of the firmware in unswappable
> kernel memory if your driver supports hot plugging (since a device
> could be plugged in at any time, not just at driver initialization).
> 

The technical advantages you give are not compelling for the Atmel 
driver. The driver has international roaming support built-in and the
firmware size is than 20k. In general though they may be good points.

I suggest that having a driver which "just works" without needing
extra files and configuration steps would trump minmizing legal
exposure to the Linux copyright holders, for most people in the real
world.

Cheers

Simon.





