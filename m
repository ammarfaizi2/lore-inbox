Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131756AbRCUUUm>; Wed, 21 Mar 2001 15:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131757AbRCUUUd>; Wed, 21 Mar 2001 15:20:33 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:4869 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S131756AbRCUUUV>; Wed, 21 Mar 2001 15:20:21 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Serge Orlov <sorlov@con.mcst.ru>,
        <linux-kernel@vger.kernel.org>,
        Jakob Østergaard <jakob@unthought.net>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com>
	<vba1yrr7w9v.fsf@mozart.stat.wisc.edu>
	<15032.1585.623431.370770@pizda.ninka.net>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: "David S. Miller"'s message of "Tue, 20 Mar 2001 17:38:57 -0800 (PST)"
Date: 21 Mar 2001 14:19:13 -0600
Message-ID: <vbay9ty50zi.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:
> 
> It is the garbage collector scheme used for memory allocation in gcc
> >=2.96 that triggers the bad cases seen by Serge.

Ahhh!  Thanks for the info.

I'm still happy to help test out the patch, but I guess it's not
likely to affect my 2.95.2 numbers much at all.  Maybe I can get a
snapshot of GCC 3.0 up and running, though, and test that out.

Thanks.

Kevin <buhr@stat.wisc.edu>
