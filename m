Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVHLDYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVHLDYd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 23:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVHLDYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 23:24:33 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:24488 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751146AbVHLDYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 23:24:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bghvflJVQ0+/hpLZfzIEAvSjhv+kFRbW9P7sHTikaKQLVJWq/GH0rpl5dH7yX9F/lpL+0QDoZ/dfOLBqfBwKmeqNk1Yj6aTq9EVjMCPGHZ+SmSiWjHqKhVLEfPKxb16nirOfh4XJSzNCCfpdahAUyE52Bl8l5FqecN9RyMrMCF0=
Message-ID: <42FC166A.3020505@gmail.com>
Date: Fri, 12 Aug 2005 12:24:26 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Boot <bootc@bootc.net>, Linux-ide <linux-ide@vger.kernel.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: SiI 3112A + Seagate HDs = still no go?
References: <12872CA9-F089-4955-8751-8CC4E7B2140A@bootc.net>
In-Reply-To: <12872CA9-F089-4955-8751-8CC4E7B2140A@bootc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Boot wrote:
> Hi all,
> 
> I just recently took the plunge and bought 4 250 GB Seagate drives  and 
> a 2 port Silicon Image 3112A controller card for the 2 drives my  
> motherboard doesn't handle. No matter how hard I try, I can't get the  
> hard drives to work: they are detected correctly and work reasonably  
> well under _very_ light load, but anything like building a RAID array  
> is a bit much and the whole controller seems to lock up.
> 
> I've tried adding the drive to the blacklist in the sata_sil.c driver  
> and I still have the same trouble: as you can see the messages below  
> relate to my patched kernel with the blacklist fix. I've seen that  this 
> was discussed just yesterday, but that seemed to give nothing:  
> http://www.ussg.iu.edu/hypermail/linux/kernel/0508.1/0310.html
> 
> Ready and willing to hack my kernel to pieces; this machine is no use  
> until I get all the drives working! Needless to say the drives  
> connected to the on-board VIA controller work fine, as do the drives  
> currently on the SiI controller if I swap them around.
> 
> Any ideas?
> 
> TIA
> Chris
> 

[added linux-ide to cc list]

  Can you please try w/ vanilla kernel (2.6.12 or 2.6.13-rc)?  And w/ 
one drive only?

-- 
tejun
