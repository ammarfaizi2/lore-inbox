Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270714AbRHKCWb>; Fri, 10 Aug 2001 22:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269793AbRHKCWW>; Fri, 10 Aug 2001 22:22:22 -0400
Received: from zeus.kernel.org ([209.10.41.242]:40325 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S270536AbRHKCWD>;
	Fri, 10 Aug 2001 22:22:03 -0400
Message-ID: <3B748AA8.4010105@blue-labs.org>
Date: Fri, 10 Aug 2001 21:30:16 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VM nuisance
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there anything measurably useful in any -ac or -pre patches after 
2.4.7 that helps or fixes the blasted out-of-memory-but-let's-go-fsck 
-ourselves-for-a-few-hours?

I was very close to hitting the reset button and losing a lot of 
important information because of this.  I accidently got too close to 
the edge of memory (~6megs free) and the kernel went into FMM (fsck 
myself mode)...i.e. spin mightily looking for memory and going noplace 
whilst ignoring it's little buddy the OOM handler.

Again, it doesn't matter if I have swap or not, if I get within ~6 megs 
of the end of memory, the kernel goes FMM.  I've tested with and without 
swap.  And _please_  don't tell me "just add more swap".  That's 
ludicruous and isn't solving the problem, it's covering up a symptom.

</rant>

So, is there anything useful or any personal/private patches I can try?

David


