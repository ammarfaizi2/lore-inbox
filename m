Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWEaUXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWEaUXW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbWEaUXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:23:22 -0400
Received: from mail.tmr.com ([64.65.253.246]:12263 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1751584AbWEaUXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:23:21 -0400
Message-ID: <447DFBA6.1010607@tmr.com>
Date: Wed, 31 May 2006 16:25:10 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
CC: kernel list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: Safe remote kernel install howto (Re: [Bugme-new] [Bug 6613]
   New: iptables broken on 32-bit PReP (ARCH=ppc))
References: <200605251004.k4PA4Lek007751@fire-2.osdl.org> <4475FCFC.5000701@trash.net> <Pine.SOC.4.61.0605261008090.14762@math.ut.ee> <200605261429.36078.netdev@axxeo.de> <Pine.SOC.4.61.0605261532140.26383@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0605261532140.26383@math.ut.ee>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:
>>> Unfortunatlety, 2.6.15 does not boot on this machine so I'm locked out
>>> remotely at the moment.
>>
>> Here it my paranoid boot setup:
> 
> Thanks, but it's not much use here, since the machine is a PReP powerpc 
> machine that can boot one kernel from disk (directly loaded from boot 
> partition, no fancy bootloader) or netboot via serial console for test 
> kernels. However, if the test kernel hangs, it hangs and I would need 
> remote power cycling device that I do not have.
> 
I did a lot of this at one time, and used lilo in just the way 
described. I did have a remote reboot device, however, an operator (1st 
shift), janitor (2nd shift), or security guard (3rd/wkend shift) who had 
been instructed to push the clearly marked reset button on demand "when 
the weird guy in New York tells you."

IBM rack units, like x345 and such, can have an "RSA" card which allows 
remote hardware monitor and reboot with a separate IP address for 
control. Worth its weight in gold! The latest will let you do remote 
console as well.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

