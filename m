Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270847AbRHXCN2>; Thu, 23 Aug 2001 22:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270848AbRHXCNT>; Thu, 23 Aug 2001 22:13:19 -0400
Received: from vp226158.uac62.hknet.com ([202.71.226.158]:4369 "EHLO
	main.coppice.org") by vger.kernel.org with ESMTP id <S270847AbRHXCNM>;
	Thu, 23 Aug 2001 22:13:12 -0400
Message-ID: <3B85B88C.4610C2D@coppice.org>
Date: Fri, 24 Aug 2001 10:14:36 +0800
From: Steve Underwood <steveu@coppice.org>
Organization: Me? Organised?
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-6.2.7 i686)
X-Accept-Language: en, zh-TW
MIME-Version: 1.0
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: releasing driver to kernel in source+binary format
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880B3E@xsj02.sjs.agilent.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"MEHTA,HIREN (A-SanJose,ex1)" wrote:
> 
> Hi list,
> 
> We want to release a linux scsi hba-driver for our fibre-channel
> HBAs and make it part of the kernel source tree. Because of IP
> related issues, we can only release one part of the sources with
> GPL. We want to release the other part in the binary format (.o)
> as a library which needs to be linked with the first part.
> If somebody can advise me on how to go about this, I would
> appreciate it.
> 
> I went through the "SubmittingDrivers" file
> which does not talk about this kind of special cases.

I for one would not buy such a thing, for the most practical of reasons.
Open source advocates are often seem as idealists. In general they are
the most pragmatic of people.

In the past year 90% of my serious problems have come from three pieces
of software - 2 text to speech packages, and Dialogic's driver from
Linux. These are the only three "binary only" things I have used, and I
am powerless to fix any of the issues causing me grief. My experience is
not unique - its commonplace.

If there is an open source alternative I think most serious Linux users
will choose that over any closed option. The closed option seldom has
enough advantage to overcome the severe risk inherent in an option that
means trusting someone who does not have your best interests at heart.
If you make your driver completely open source, we would still have to
trust your hardware. Experience says that isn't such a big problem. Few
pieces of computer hardware, which actually reach the market, have
proven so bad that the problems cannot be worked around (perhaps with a
little performance loss) in software. Closed hardware doesn't scare
seasoned users like closed software.

That said.... If your closed code actually consists of something
dwownloaded to the card, you may still be able to supply a GPL kernel
bit, and a binary only downloaded bit. If you want an integral part of
your host driver code to be binary only, you can't do that.

Regards,
Steve
