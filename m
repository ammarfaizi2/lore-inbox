Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131931AbQKDJYf>; Sat, 4 Nov 2000 04:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132415AbQKDJYZ>; Sat, 4 Nov 2000 04:24:25 -0500
Received: from ra.lineo.com ([204.246.147.10]:51123 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S131931AbQKDJYP>;
	Sat, 4 Nov 2000 04:24:15 -0500
Message-ID: <3A03D466.738ED67@Rikers.org>
Date: Sat, 04 Nov 2000 02:18:30 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Sethman <androsyn@ratbox.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
In-Reply-To: <Pine.LNX.4.21.0011040031450.11261-100000@squeaker.ratbox.org>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 11/04/2000
 02:24:10 AM,
	Serialize complete at 11/04/2000 02:24:10 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is also a nice thought, but there is an obstacle.

The Pro64 tools are Open Source and GPLed:

http://oss.sgi.com/projects/Pro64/

SGI retains the copyright to the code.

As far as I know, the FSF owns the copyright to all code in the gcc
suite. If improvements were taken from the Pro64 tools the copyright to
said code would have to remain.

>From what I understand the FSF will not allow any code to be added to
gcc that is not copyright by the FSF. Intel has offered direct patches
to gcc to support better optimizations for Itanium. Some of there
patches improve performance on other platforms. As far as I know the gcc
team has not even looked at the patches but has required that full
copyright be transferred to the FSF first.

I understand there are other hardware vendors who have written patches
only to be met by this same adamant position taken by the FSF.

Others that are commenting on the slow progress of some features in gcc
should consider for themselves whether this position benefits the Open
Source community or not.

Note: it _is_ clear that this position _could_ be of _some_ benefit to
the Free Software community as it places the FSF in a more defensible
position if there were ever a legal dispute on pirated sections of the
FSF copyrighted code.

Aaron Sethman wrote:
> 
> On Thu, 2 Nov 2000, Andi Kleen wrote:
> 
> > On Thu, Nov 02, 2000 at 07:07:12PM +0000, Alan Cox wrote:
> > > > 1. There are architectures where some other compiler may do better
> > > > optimizations than gcc. I will cite some examples here, no need to argue
> > >
> > > I think we only care about this when they become free software.
> >
> > SGI's pro64 is free software and AFAIK is able to compile a kernel on IA64.
> > It is also not clear if gcc will ever produce good code on IA64.
> 
> Well if its compiling the kernel just fine without alterations to the
> code, then fine. If not, if the SGI compiler is GPL'd pillage its sources
> and get that code working in gcc. Otherwise, trying to get linux to work
> with other C compilers doesn't seem worth the effort.
> 
> Aaron
-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
