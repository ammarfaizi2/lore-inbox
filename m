Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbUJYT75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbUJYT75 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbUJYTzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:55:35 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:43409 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261278AbUJYTuc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:50:32 -0400
Message-ID: <417D5991.3050003@tmr.com>
Date: Mon, 25 Oct 2004 15:52:49 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: 2.6.9-mm1
References: <20041022032039.730eb226.akpm@osdl.org><20041022032039.730eb226.akpm@osdl.org> <4179425A.3080903@namesys.com>
In-Reply-To: <4179425A.3080903@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

> I would like to encourage its inclusion as an experimental filesystem 
> BEFORE vendors ship it. I think first putting experimental stuff in the 
> kernels used by hackers makes sense. I think it creates more of a 
> community.

I think -mm *is* what is run by hackers. That said, do you really think 
that it is stable with 4k stack? (that's a real question, it wasn't for 
me in 2.6.8-mm? when I briefly tried it).

I see the major benefits to people running heavy i/o load, like database 
and servers. And those are the users with the most to lose if it still 
has residual learning experiences.

I do think that akpm is capable of deciding when it should go in without 
all this politicing, and I doubt he or Linus care if it makes a vendor 
kernel first, considering all the things in vendor kernels which NEVER 
get to mainline.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
