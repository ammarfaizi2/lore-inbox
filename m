Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273268AbRINDCL>; Thu, 13 Sep 2001 23:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273269AbRINDCB>; Thu, 13 Sep 2001 23:02:01 -0400
Received: from paloma17.e0k.nbg-hannover.de ([62.159.219.17]:52936 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S273268AbRINDBt>; Thu, 13 Sep 2001 23:01:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Robert Love <rml@tech9.net>
Subject: Re: Feedback on preemptible kernel patch
Date: Fri, 14 Sep 2001 04:47:32 +0200
X-Mailer: KMail [version 1.3]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010914030157Z273268-760+12546@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

> Hi Arjan,
>
> first, highmem is fixed and the original patch you have from me is good.
> second, Daniel Phillips gave me some feedback into how to figure out the
> VM error.  I am working on it, although just the VM potential

Good to hear.

> -- ReiserFS may be another problem.

Can't wait for that.

> third, you may be experiencing problems with a kernel optimized for
> Athlon.  this may or may not be related to the current issues with an
> Athlon-optimized kernel.  Basically, functions in arch/i386/lib/mmx.c
> seem to need some locking to prevent preemption.  I have a basic patch
> and we are working on a final one.

Can you please send this stuff along to me?
You know I own an Athlon (since yester Athlon II 1 GHz :-) and need some 
input...

Mobo is MSI MS-6167 Rev 1.0B (AMD Irongate C4, yes the very first one)

Kernel with preempt patch and mmx/3dnow! optimization crash randomly.
Never had that (without preempt) during the last two years.

Thanks,
	Dieter

