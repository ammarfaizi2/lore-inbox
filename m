Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVGFX4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVGFX4O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVGFXyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 19:54:11 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:50180 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262237AbVGFUGD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:06:03 -0400
Message-ID: <42CC3A70.4030706@tmr.com>
Date: Wed, 06 Jul 2005 16:09:20 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: matthieu castet <castet.matthieu@free.fr>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd and bad sectors
References: <42C6A12A.8030009@free.fr> <1120579233.23118.22.camel@localhost.localdomain> <42CACF8D.2060203@free.fr>
In-Reply-To: <42CACF8D.2060203@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthieu castet wrote:
> Hi Alan,
> 
> Alan Cox wrote:
> 
>> On Sad, 2005-07-02 at 15:14, matthieu castet wrote:
>>
>>> Also I was wondering if all the sector that ide-cd failed to read are 
>>> bad sector, or if ide-cd failed to put the drive in a consistent 
>>> state for reading the next sector after corrupted one.
>>
>>
>>
>> ide-cd wrongly errors all the sectors around an error, ide-scsi gets it
>> right if the IDE firmware does. I sent Bartlomiej patches to fix that
>> and I believe he accepted them
>>
> thanks,
> 
> they don't seem to be in his tree : 
> http://www.kernel.org/git/?p=linux%2Fkernel%2Fgit%2Fbart%2Fide-2.6.git&a=search&s=ide-cd 
> :(
> 
> Matthieu
Alan, maybe you could send them again, it would be nice to have a 
useable ide-cd capability which doesn't prevent reading the good sectors 
on a CD.
