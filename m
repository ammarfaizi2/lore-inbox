Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280016AbRKVQiK>; Thu, 22 Nov 2001 11:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280026AbRKVQiA>; Thu, 22 Nov 2001 11:38:00 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:3500 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S280016AbRKVQhy>;
	Thu, 22 Nov 2001 11:37:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: war <war@starband.net>
Subject: Re: Swap vs No Swap.
Date: Thu, 22 Nov 2001 08:37:18 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3BFC5A9B.915B77DF@starband.net> <E166rbB-0005LC-00@mauve.csi.cam.ac.uk> <3BFD2709.31A1A85E@starband.net>
In-Reply-To: <3BFD2709.31A1A85E@starband.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E166wqm-0004XF-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 22, 2001 08:25, war wrote:
> Why have SWAP if you don't need it - answer that.?

> > BS. You don't use swap INSTEAD of RAM, but AS WELL AS. Moving less
> > frequently used data to swap allows you to put more frequently used data
> > in RAM, which DOES speed things up. (At least, it does if the VM system
> > works properly :P)

Are you even reading what they're saying? Having swap lets you move less 
frequently used data to disk in favour of having more frequently used data in 
RAM. 

Personally, I have more than enough RAM to run a fairly busy KDE2 desktop, 
and still have over 128megs in disk cache. And I still run with swap. The VM 
seems to find about 40megs of data I'm -simply not using-, and it now has the 
freedom to push that to swap so it can cache things that I -do use-. Although 
the more RAM you have, the less significant the results are, you'll find that 
in normal desktop/workstation/server use, the kernel will -always- find 
something to swap out to give itself more cache, and more cache is a very 
good thing. It's not fucking rocket science.

-Ryan
