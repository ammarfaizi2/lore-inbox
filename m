Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265701AbRF1NGD>; Thu, 28 Jun 2001 09:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265707AbRF1NFx>; Thu, 28 Jun 2001 09:05:53 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:3332 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S265701AbRF1NFp>;
	Thu, 28 Jun 2001 09:05:45 -0400
Date: Thu, 28 Jun 2001 15:05:41 +0200 (CEST)
From: Tobias Ringstrom <tori@unhappy.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Helge Hafting <helge.hafting@idb.hist.no>,
        Martin Knoblauch <Martin.Knoblauch@TeraPort.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <993731477.9213.4.camel@nomade>
Message-ID: <Pine.LNX.4.33.0106281439420.1258-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jun 2001, Xavier Bestel wrote:

> On 28 Jun 2001 14:02:09 +0200, Tobias Ringstrom wrote:
>
> > This would be very useful, I think.  Would it be very hard to classify
> > pages like this (text/data/cache/...)?
>
> How would you classify a page of perl code ?

I do know how the Perl interpreter works, but I think it byte-compiles the
code and puts it in the data segment, which also would have a high paging
cost.

The perl source code would be paged in/out before running binaries such as
shells and the window system, but the same thing would happen to binaries
with short life-span, I suppose.  Perhaps cached executables and cached
data files can be classified differently as well.

What I meant to ask with the question above was if it would be hard to
implement the classification in the kernel.

/Tobias

