Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbVHMO7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbVHMO7e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 10:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVHMO7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 10:59:34 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:32369 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750905AbVHMO7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 10:59:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=b3AySSEa9OsXw3lu8BhlZPPXFeb3KAXZ+bjCGKXKUhMYP6AUCVmxbry9XWkLGRGDWwnqUZzflLDZAwf2NG8ylM/gbE+f8KChRaQURoH50uC7ATMgUfWl+/ZLofwIxANNbwW0uV801b7b48xBsbZyS4Fl2g+qTAZ0qrzDh0aQ6D0=
Message-ID: <42FE0ACE.6010506@gmail.com>
Date: Sat, 13 Aug 2005 23:59:26 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Boot <bootc@bootc.net>
CC: Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: SiI 3112A + Seagate HDs = still no go?
References: <12872CA9-F089-4955-8751-8CC4E7B2140A@bootc.net> <42FC166A.3020505@gmail.com> <0FDE8D5B-CFF2-44F9-8C98-9C5EC5CDAE92@bootc.net> <42FC87ED.6030201@gmail.com> <22B1D7C7-7BC8-449C-914C-FCE5226BCAF2@bootc.net> <655E2636-B4D4-42EC-B10C-C8B8EFA09E33@bootc.net> <42FCAD4D.7080707@gmail.com> <74C9A166-2FDC-45F8-BEB1-A574FD9602D4@bootc.net> <42FD493D.8020506@gmail.com> <EB750DA5-854F-4387-A5D7-F646EB8E7AAC@bootc.net>
In-Reply-To: <EB750DA5-854F-4387-A5D7-F646EB8E7AAC@bootc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Boot wrote:
> Some interesting developments!
> 
> I installed a fresh copy of Windows, and all the VIA and nVidia and  so 
> on drivers. At some point during all this (a period of relatively  heavy 
> disk IO), the computer seemed to crash and I rebooted it. It  then 
> worked fine for a while, but during my perfmon testing it seemed  to do 
> the same thing. This time I left it for a while and it did  eventually 
> wake up again, so I'm guessing the controller is a bit  fubared. Perfmon 
> did indeed show several dips down to or very close  to 0 during the 
> write operation, with peaks up to 48 MB/sec, which is  pretty 
> respectable. So, time to replace the brand-new controller I  guess.
> 
> Now, do you think this is just my one particular controller card and  a 
> simple return would fix the problem, or is it more likely a problem  
> with the whole range? It's an Innovision EIO SATA controller: http:// 
> www.ivmm.com/eio/products/index.htm
> 
> Would it be a safer bet to go for the Adaptec controller of the same  
> variety? How reliable are they?

  I frankly don't know.  Maybe it's just one faulty controller, 
connector or whatever.  Maybe the card manufacturer screwed up 
somewhere.  I mean, the only course I took in electronics is 
introductory digital circuits which used 74xx chips and push triggered 
clock on a breadboard.  What would I know about gigahertz signaling 
error.  :-p

  Though, one thing I can say is majority of 311x controllers don't seem 
to suffer from this problem.  So, take your pick.

-- 
tejun
