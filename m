Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWACXNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWACXNe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWACXNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:13:08 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:52573 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964865AbWACXMv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:12:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dPe1K+gU+vJlH/WNwf037nahVvUB47p1RvbDSEcdVVlRn9QtUuDY8aPuLuhUHISAZ7XY+Di50iQcJCoU6wq9sgB7h/GeFgb62YjA6IOqr8UNd7EkPASwxB1y/nzdjx4sJXTVIfklqgD8My6J3TmTTnykpXxp2QG0Po+MY4AaERo=
Message-ID: <9c21eeae0601031512m44c4a269ua2214528eaf90914@mail.gmail.com>
Date: Tue, 3 Jan 2006 15:12:50 -0800
From: David Brown <dmlb2000@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-rt1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060103094720.GA16497@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060103094720.GA16497@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/06, Ingo Molnar <mingo@elte.hu> wrote:
> i have released the 2.6.15-rt1 tree, which can be downloaded from the
> usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>
> no big changes, this release is mainly a merge to v2.6.15, and should
> fix some of the RTC driver problems reported for 2.6.15-rc7-rt3.
>
> to build a 2.6.15-rt1 tree, the following patches should be applied:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.15-rt1
>
>         Ingo


hmm compile problem with this one....
since this is the first time I've tried this patch I don't know how
far back this goes.

  CC [M]  net/ipv6/icmp.o
  CC [M]  net/ipv6/mcast.o
net/ipv6/mcast.c: In function `ipv6_sock_mc_join':
net/ipv6/mcast.c:227: error: `RW_LOCK_UNLOCKED' undeclared (first use
in this function)
net/ipv6/mcast.c:227: error: (Each undeclared identifier is reported only once
net/ipv6/mcast.c:227: error: for each function it appears in.)
make[2]: *** [net/ipv6/mcast.o] Error 1
make[1]: *** [net/ipv6] Error 2
make: *** [net] Error 2

- David Brown
