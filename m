Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbTI3M1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTI3M1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:27:10 -0400
Received: from hermes.domdv.de ([193.102.202.1]:3598 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id S261403AbTI3M1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:27:05 -0400
Message-ID: <3F797690.4020706@domdv.de>
Date: Tue, 30 Sep 2003 14:26:56 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030711
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
References: <200309301144.h8UBiUUF004315@burner.fokus.fraunhofer.de> <20030930115411.GL2908@suse.de> <3F797316.2010401@domdv.de> <20030930122137.GN2908@suse.de>
In-Reply-To: <20030930122137.GN2908@suse.de>
X-Enigmail-Version: 0.76.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Sep 30 2003, Andreas Steinmetz wrote:
> 
>>Jens Axboe wrote:
>>
>>>I think I do.
>>>
>>>
>>>
>>>>In order to use kernel interfaces you _need_ to include kernel include
>>>>files.
>>>
>>>
>>>False. You need to include the glibc kernel headers.
>>>
>>
>>Then please tell me why PPPIOCNEWUNIT is only defined in linux/if_ppp.h 
>>and not net/if_ppp.h which is still true for glibc-2.3.2. And please 
>>don't tell me to ask the glibc folks. There are inconsistencies between 
>>kernel headers and userland headers which force the inclusion of kernel 
>>headers in userland applications.
> 
> 
> I will tell you to talk to the glibc folks, because that's where your
> problem is.
> 
I don't think so. If ioctls are introduced in the kernel the kernel 
people should propagate these to the glibc people. I don't think it is 
the task of userland developers.
But then this is my point of view and I don't think it necessary to 
discuss this further.

-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

