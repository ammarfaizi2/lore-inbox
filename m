Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266530AbRGDHuR>; Wed, 4 Jul 2001 03:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266531AbRGDHuH>; Wed, 4 Jul 2001 03:50:07 -0400
Received: from mail.bmlv.gv.at ([193.171.152.34]:53428 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S266530AbRGDHt7>;
	Wed, 4 Jul 2001 03:49:59 -0400
Message-Id: <3.0.6.32.20010704095314.009201b0@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Wed, 04 Jul 2001 09:53:14 +0200
To: Daniel Phillips <phillips@bonn-fries.net>
From: "Ph. Marek" <marek@bmlv.gv.at>
Subject: Re: Ideas for TUX2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01070408542401.03760@starship>
In-Reply-To: <3.0.6.32.20010704081621.00921a60@pop3.bmlv.gv.at>
 <3.0.6.32.20010703082513.0091f900@pop3.bmlv.gv.at>
 <3.0.6.32.20010704081621.00921a60@pop3.bmlv.gv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> If a file's data has been changed, it suffices to update the inode and
>> >> the of free blocks bitmap (fbb).
>> >> But updating them in one go is not possible
>> >
>> >You seem to have missed some fundamental understanding of
>> >exactly how phase tree works; the wohle point of phase
>> >tree is to make atomic updates like this possible!
>>
>> Well, my point was, that with several thousand inodes spread over the disk
>> it won't always be possible to update the inode AND the fbb in one go.
>> So I proposed the 2nd inode with generation counter!
>
>The cool thing is, it *is* possible, read how here:
>
>  http://nl.linux.org/~phillips/tux2/phase.tree.tutorial.html
Well, ok. Your split the inode "files" too.

Hmmm...
That sound more complex than my version (at least now, until I've seen the
implementation - maybe it's easier because it has less special cases than
mine).

And of course the memory usage on the harddisk is much less with your
version as you split your inode data and don't have it duplicated.

Well, I hope to see an implementation soon - I'd like to help, even if it's
only testing.


Thanks for the answer!


Regards,

Phil

