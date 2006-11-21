Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934304AbWKUElJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934304AbWKUElJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 23:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934306AbWKUElJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 23:41:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:61924 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S934304AbWKUElG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 23:41:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rAlMQFtxRpvHue7oGscYCr8DCq5qFrYlX1wSpy7kbJP5VHX0GbQl8Lxkzkhm2YcfCzNj4XsFS/Z13H5x1dPivrCFsQXjNT+UEQZZM2OrF/eeF/21ZLDRAv/zFksE1mUpovm16Q8ynk5CFfjlzwehkmOWF805/lIQUL/IdrHRNuI=
Message-ID: <45628358.8080504@gmail.com>
Date: Tue, 21 Nov 2006 13:40:56 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Jeff Garzik <jeff@garzik.org>, Andi Kleen <ak@suse.de>,
       Pavel Machek <pavel@ucw.cz>, John Fremlin <not@just.any.name>,
       kernel list <linux-kernel@vger.kernel.org>, jim.kardach@intel.com
Subject: Re: AHCI power saving (was Re: Ten hours on X60s)
References: <87k639u55l.fsf-genuine-vii@john.fremlin.org> <20061113142219.GA2703@elf.ucw.cz> <45589008.1080001@garzik.org> <200611131637.56737.ak@suse.de> <455893E5.4010001@garzik.org> <4558B232.8080600@rtr.ca>
In-Reply-To: <4558B232.8080600@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
>> Andi Kleen wrote:
>>
>>> How does it shorten its life?
>>
>> Parks your hard drive heads many thousands of times more often than it 
>> does without the aggressive PM features.
> 
> Spinning-down would definitely shorten the drive lifespan.  Does it do 
> that?
> 
> Parking heads is more like just doing some extra (long) seeks.
> Is this documented somewhere as being a life-shortening action?

I wrote this in the other thread but writing here too for documentation 
purpose.

* HL-DT-ST DVD-RAM GSA-H30N locks up completely on slumber.  Physical 
power removal and reapply is the only to recover it.

* Some WD raptors spin down (yeap, that's right, it spins down) on slumber.

Wonderful world of ATA.  :-P

-- 
tejun
