Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVGLOsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVGLOsF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVGLOrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:47:48 -0400
Received: from relay03.pair.com ([209.68.5.17]:26119 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S261493AbVGLOrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:47:11 -0400
X-pair-Authenticated: 209.68.2.107
Message-ID: <42D3D7ED.7000805@cybsft.com>
Date: Tue, 12 Jul 2005 09:47:09 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Daniel Walker <dwalker@mvista.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
References: <200507121223.10704.annabellesgarden@yahoo.de> <20050712140251.GB18296@elte.hu> <1121178339.10199.8.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050712142828.GA20798@elte.hu>
In-Reply-To: <20050712142828.GA20798@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> 
>>I observed a situation on a dual xeon where IOAPIC_POSTFLUSH , if on, 
>>would actually cause spurious interrupts. It was odd cause it's 
>>suppose to stop them .. If there was a lot of interrupt traffic on one 
>>IRQ , it would cause interrupt traffic on another IRQ. This would 
>>result in "nobody cared" messages , and the storming IRQ line would 
>>get shutdown.
>>
>>This would only happen in PREEMPT_RT .
> 
> 
> does it happen with the latest kernel too? There were a couple of things 
> broken in the IOAPIC code in various earlier versions.
> 
> 	Ingo

Is this why I have been able to boot the latest versions without the 
noapic option (and without noticeable keyboard repeat problems) or has 
it just been dumb luck?

-- 
    kr
