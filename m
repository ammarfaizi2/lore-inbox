Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUBROeH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 09:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUBROeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 09:34:06 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:20694
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S267431AbUBROeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 09:34:01 -0500
Message-ID: <4033737D.5030601@tmr.com>
Date: Wed, 18 Feb 2004 09:15:25 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Christophe Saout <christophe@saout.de>, hch@infradead.org,
       thornber@redhat.com, mikenc@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: dm-crypt using kthread
References: <20040216014433.GA5430@leto.cs.pocnet.net> <20040215175337.5d7a06c9.akpm@osdl.org>
In-Reply-To: <20040215175337.5d7a06c9.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Christophe Saout <christophe@saout.de> wrote:
> 
>>+	  This device-mapper target allows you to create a device that
>> +	  transparently encrypts the data on it. You'll need to activate
>> +	  the required ciphers in the cryptoapi configuration in order to
>> +	  be able to use it.
> 
> 
> Is there more documentation that this?  I'd imagine a lot of crypto-loop
> users wouldn't have a clue how to get started on dm-crypt, especially if
> they have not used device mapper before.
> 
> And how do they migrate existing encrypted filesytems?

And there are a reasonable number of us who build kernels without dm, 
lvm, and actually run working servers on them.

Having not had problems with either file or device backed cryptoloop I'm 
not eager to go do some new gee-whiz thing which require training time, 
new bugs to be fixed (unless you think this is more perfect than 
anything else in the kernel), etc.

Taking features out of a stable kernel, particularly those which work 
for many people, doesn't sound right, somehow. New features don't break 
existing setups, but removal of a feature seems to be more appropriate 
for 2.7. Of course by them it's likely that bugs will be removed and 
there will be no justification to remove it.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
