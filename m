Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTIJLoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 07:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbTIJLoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 07:44:38 -0400
Received: from dyn-ctb-203-221-72-196.webone.com.au ([203.221.72.196]:43526
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262543AbTIJLog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 07:44:36 -0400
Message-ID: <3F5F0E9D.6090606@cyberone.com.au>
Date: Wed, 10 Sep 2003 21:44:29 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Luca Veraldi <luca.veraldi@katamail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <20030910095255.GA21313@mail.jlokier.co.uk> <20030910120729.C14352@devserv.devel.redhat.com> <20030910103752.GC21313@mail.jlokier.co.uk> <20030910124151.C9878@devserv.devel.redhat.com> <02bc01c37789$ebfa9a40$5aaf7450@wssupremo> <3F5F0820.3090003@cyberone.com.au> <036a01c3778e$ebadc080$5aaf7450@wssupremo>
In-Reply-To: <036a01c3778e$ebadc080$5aaf7450@wssupremo>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Luca Veraldi wrote:

>>Hi Luca,
>>There was a zero-copy pipe implementation floating around a while ago
>>I think. Did you have a look at that? IIRC it had advantages and
>>disadvantages over regular pipes in performance.
>>
>
>Sorry, but i subscripted this mailing-list only one day ago.
>Advantages and disadvantages depends on what actually you implement
>and on how you do that.
>

Yes you're right. Just search for it. It would be interesting to compare
them with your implementation.

>
>I can only say that capabilities are a disadvantage only with very very
>short messages
>(that is, a few bytes). And this disadvantage is theoretically demonstrable.
>
>But, let's say also that such elementary messages are meaningful only in the
>kernel
>and for kernel purposes.
>
>User processes are another tail.
>

I'm not too sure, I was just pointing you to zero copy pipes because
they did have some disadvantages which is why they weren't included in
the kernel. Quite possibly your mechanism doesn't suffer from these.

What would really help convince everyone is, of course, "real world"
benchmarks. I like your ideas though ;)



