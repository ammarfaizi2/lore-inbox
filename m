Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUBDDQh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 22:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUBDDQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 22:16:37 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:59582 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266198AbUBDDQf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 22:16:35 -0500
Message-ID: <40205908.4080600@cyberone.com.au>
Date: Wed, 04 Feb 2004 13:29:28 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: More VM benchmarks
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kerneltrap.org/~npiggin/vm/5/

OK I'm not too unhappy with kbuild now. I've flattened the
curve a bit more since you last saw it. Would be nice if we
could get j8 and j10 faster but you can't win them all.

I'm not sure what happens further on - Roger indicates that
perhaps 2.4 overtakes 2.6 again at j24 although the patchset
he used (http://www.kerneltrap.org/~npiggin/vm/3/) performs
far worse than this one at j16. This is really not a big
deal IMO, but I might run it and see what happens.

The systime benchmarks are just a bit of fun. They don't
mean too much because I didn't measure how much work kswapd
is doing...

Oh, the base kernel is 2.6.2-rc3-mm1 for -np3. I'll release
the patches shortly.

Best regards,
Nick

