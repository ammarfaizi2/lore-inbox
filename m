Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269372AbRHQBcW>; Thu, 16 Aug 2001 21:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269392AbRHQBcM>; Thu, 16 Aug 2001 21:32:12 -0400
Received: from mail.erisksecurity.com ([208.179.59.234]:34685 "EHLO
	Tidal.eRiskSecurity.com") by vger.kernel.org with ESMTP
	id <S269372AbRHQBcE>; Thu, 16 Aug 2001 21:32:04 -0400
Message-ID: <3B7C7416.2060006@blue-labs.org>
Date: Thu, 16 Aug 2001 21:32:06 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010815
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: A.J.Scott@casdn.neu.edu,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8 aic7xxx -- continuous bus resets
In-Reply-To: <200108170001.f7H01GI82362@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IIRC, the fix for this in my situation was due to the pci irq routing on 
that particular motherboard and using noapic solved it.

Has the irq routing been fixed to date?

David

Justin T. Gibbs wrote:

>>I thought I'd look at the 2.4.8 kernel while I figure out what's 
>>wrong with my 2.2.18 installation. The kernel loading gets stuck with 
>>errors from the aic7xxx driver, which keeps timeing out querying the 
>>bus looking for non-existant drives, and when it finaly tries to 
>>query a drive that exists it claims to see bus errors. End result is 
>>that Linux 2.4.8 never mounts any drives or finishes loading.
>>
>>The system is an IBM 704 with a built in adaptec aic-7880U 
>>controller, with two drives on first scsi buss. 
>>
>>2.2.18 has no problems with the adaptec controllers, but has other 
>>issues, which seem to be timer related.
>>
>
>2.4.9 has the latest aic7xxx driver in it.  Can you see if that changes
>things for you?  If not, can you hook up a serial console to the machine
>and provide all of the messages from an aic7xxx=verbose boot?
>


