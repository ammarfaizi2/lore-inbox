Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281325AbRKHChg>; Wed, 7 Nov 2001 21:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281315AbRKHCh0>; Wed, 7 Nov 2001 21:37:26 -0500
Received: from Sioux.meginc.com ([207.246.76.19]:45316 "EHLO sioux.meginc.com")
	by vger.kernel.org with ESMTP id <S281293AbRKHChO>;
	Wed, 7 Nov 2001 21:37:14 -0500
Message-Id: <200111080234.VAA70065@sioux.meginc.com>
Content-Type: text/plain; charset=US-ASCII
From: Brandon Barker <bebarker@meginc.com>
To: Robert Love <rml@tech9.net>
Subject: Re: AGPGART build problem in 2.4.14
Date: Wed, 7 Nov 2001 21:38:28 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200111070323.WAA01534@sioux.meginc.com> <1005172631.939.6.camel@phantasy>
In-Reply-To: <1005172631.939.6.camel@phantasy>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You were correct, __i386__  was incorrectly defined in my specs file (my 
fault.)  And thanks for the Preemptive Kernel patch!

Brandon Barker

On Wednesday 07 November 2001 05:37 pm, Robert Love wrote:
> On Tue, 2001-11-06 at 22:27, Brandon Barker wrote:
> > The following problem occured while building linux 2.4.14 while trying to
> > make the agpgart driver (system is Intel/Redhat 7.2):
> >
> > If this problem is resolved please tell me, I'd be very appreciative.
> > Brandon Barker
>
> I can't duplicate the problem.  Have you tried recompiling since the
> post?
>
> Do a full clean `make oldconfig dep clean bzImage'
>
> I can't figure why your flush isn't being defined, since it should be as
> long as __i386__ is defined.
>
> 	Robert Love
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
