Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318983AbSH1UZK>; Wed, 28 Aug 2002 16:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318980AbSH1UZK>; Wed, 28 Aug 2002 16:25:10 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:56719 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S318983AbSH1UZI>; Wed, 28 Aug 2002 16:25:08 -0400
Date: Wed, 28 Aug 2002 22:27:43 +0200
From: Dominik Brodowski <devel@brodo.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Message-ID: <20020828222743.B816@brodo.de>
References: <1030562494.7190.53.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.33.0208281246560.4507-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.LNX.4.33.0208281246560.4507-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Aug 28, 2002 at 12:49:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 12:49:31PM -0700, Linus Torvalds wrote:
> 
> On 28 Aug 2002, Alan Cox wrote:
> > 
> > You might want to read the paper on the original cpufreq for ARM. It
> > gives real world cases where the user -needs- to be able to control the
> > policy. I think you misunderstand what the interface is about. Large
> > numbers of systems benefit from usermode policy engines.
> 
> That's not the point.
> 
> The point is that the _policy_ (not the end result) needs to be pushed 
> down to the kernel, so that the kernel can do the right thing with it.
> 
> That policy can be updated in "real time" from user space, of course. But 
> the fact is that you cannot just set a frequency and leave it at that, it 
> doesn't work.

On the long term, maybe. But cpufreq is only the driver, which lets you have
such a policy engine in the kernel. And as long as this policy engine
doesn't exist, why not offer the user some control over his system?

	Dominik
