Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270673AbRHJW5k>; Fri, 10 Aug 2001 18:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270676AbRHJW5a>; Fri, 10 Aug 2001 18:57:30 -0400
Received: from weta.f00f.org ([203.167.249.89]:38033 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S270672AbRHJW5P>;
	Fri, 10 Aug 2001 18:57:15 -0400
Date: Sat, 11 Aug 2001 10:58:19 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Remotely rebooting a machine with state 'D' processes, how?
Message-ID: <20010811105819.A1299@weta.f00f.org>
In-Reply-To: <200108102159.f7ALxb908284@penguin.transmeta.com> <E15VL6x-0007Jm-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15VL6x-0007Jm-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2001 at 08:50:35AM +1000, Herbert Xu wrote:

    How do you do this when the process in the D state is holding the BKL?

On ia32:

        outb(0xfe, 0x64);

I have a command-line proglet for doing this, and also a patch to add
to SysReq is people really want such a thing.



  --cw

