Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289053AbSAIWQV>; Wed, 9 Jan 2002 17:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289049AbSAIWQQ>; Wed, 9 Jan 2002 17:16:16 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:33173 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S289050AbSAIWP4>; Wed, 9 Jan 2002 17:15:56 -0500
Message-ID: <3C3CC176.83F49A74@oracle.com>
Date: Wed, 09 Jan 2002 23:17:26 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Lord <lord@sgi.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 umount oops in 2.5.2-pre10
In-Reply-To: <1010601760.29727.138.camel@jen.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:
> 
> It looks like ext3 does not work if you do not use an external
> journal device - the journal_bdev field is not initialized and
> ext3_put_super goes belly up:

I have seen the umount oops -but- not 100% of the time. No time
 to copy the oops text since my laptop powers off, and as the
 issue occurred two times out of five or six, I haven't yet had
 a very strong need to hunt this further, confident someone more
 clueful than me (possibly the vast majority of l-k :) would do
 very soon. It looks like it happened. Heh. As always.

> At the very least it needs this:

[snipped patch]

OK, going to the usual patch/build/reboot/test sequence now.

Will let you know in 2 days at most. Thanks !

--alessandro

 "this machine will, will not communicate
   these thoughts and the strain I am under
  be a world child, form a circle before we all go under"
                         (Radiohead, "Street Spirit [fade out]")
