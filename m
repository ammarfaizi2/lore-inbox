Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265072AbSKAQKN>; Fri, 1 Nov 2002 11:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbSKAQKM>; Fri, 1 Nov 2002 11:10:12 -0500
Received: from codepoet.org ([166.70.99.138]:34454 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S265072AbSKAQJh>;
	Fri, 1 Nov 2002 11:09:37 -0500
Date: Fri, 1 Nov 2002 09:16:04 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021101161603.GA25306@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <20021031181252.GB24027@tapu.f00f.org> <Pine.LNX.4.44.0210311040080.1526-100000@penguin.transmeta.com> <20021031194351.GA24676@tapu.f00f.org> <apu6cd$4db$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apu6cd$4db$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Nov 01, 2002 at 03:25:01PM +0000, Linus Torvalds wrote:
> funny - I'd be surprised if RL throughput copying back and forth over a
> PCI bus is more than 25-30MB/s), I suspect that you can do most crypto
> faster on the CPU directly these days. 
> 
> Maybe not. The only numbers I have is the slowness of PCI.

It may be faster on your beefy 8 CPU boxes.  But many people are
creating, for example, little wireless access points with 200 Mhz
StrongArm CPUs and similar little devices that lack the major CPU
horsepower of big-iron system.  Such boxes would be far better
off offloading crypto to a little crypto chip, right?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
