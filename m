Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318929AbSH1Tm6>; Wed, 28 Aug 2002 15:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318931AbSH1Tm6>; Wed, 28 Aug 2002 15:42:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23571 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318929AbSH1Tm5>; Wed, 28 Aug 2002 15:42:57 -0400
Date: Wed, 28 Aug 2002 12:49:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dominik Brodowski <devel@brodo.de>, <cpufreq@www.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
In-Reply-To: <1030562494.7190.53.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0208281246560.4507-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28 Aug 2002, Alan Cox wrote:
> 
> You might want to read the paper on the original cpufreq for ARM. It
> gives real world cases where the user -needs- to be able to control the
> policy. I think you misunderstand what the interface is about. Large
> numbers of systems benefit from usermode policy engines.

That's not the point.

The point is that the _policy_ (not the end result) needs to be pushed 
down to the kernel, so that the kernel can do the right thing with it.

That policy can be updated in "real time" from user space, of course. But 
the fact is that you cannot just set a frequency and leave it at that, it 
doesn't work.

		Linus

