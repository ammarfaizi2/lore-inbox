Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266528AbUGPMP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266528AbUGPMP3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 08:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266532AbUGPMP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 08:15:29 -0400
Received: from burro.logi-track.com ([213.239.193.212]:6803 "EHLO
	mail.logi-track.com") by vger.kernel.org with ESMTP id S266528AbUGPMPY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 08:15:24 -0400
Date: Fri, 16 Jul 2004 14:15:21 +0200
From: Markus Schaber <schabios@logi-track.com>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: New mobo question
Message-Id: <20040716141521.02c5422f@kingfisher.intern.logi-track.com>
In-Reply-To: <20040716112007.GA14641@taniwha.stupidest.org>
References: <200407160552.27074.gene.heskett@verizon.net>
	<20040716112007.GA14641@taniwha.stupidest.org>
Organization: logi-track ag, =?ISO-8859-15?Q?z=FCrich?=
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: Nx5T&>Nj$VrVPv}sC3IL&)TqHHOKCz/|)R$i"*r@w0{*I6w;UNU_hdl1J4NI_m{IMztq=>cmM}1gCLbAF+9\#CGkG8}Y{x%SuQ>1#t:;Z(|\qdd[i]HStki~#w1$TPF}:0w-7"S\Ev|_a$K<GcL?@F\BY,ut6tC0P<$eV&ypzvlZ~R00!A
X-PGP-Key: http://schabi.de/pubkey.asc
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chris,

On Fri, 16 Jul 2004 04:20:07 -0700
Chris Wedgwood <cw@f00f.org> wrote:

> On Fri, Jul 16, 2004 at 05:52:27AM -0400, Gene Heskett wrote:
> 
> > I've ordered a new mobo as I'm having what appears to be data bus
> > problems with this one after a rather spectacular failure of a
> > gforce2 video card, memtest86 says I have a lot of errors where
> > 00000020 was written, but 00000000 came back, at semi-random
> > locations scattered thoughout half a gig of dimms running at half
> > their rated DDR266 speed.  The last nibble of the address is always
> > zero, and the next nibble is always even.
> 
> Get the board replaced.

Read his first sentence and you will see that he has already ordered a
new board.

> > Is there a way to prebuild a kernel that will run on both boards?,
> > this older board is a VIA82686/VIA8233 based board, a Biostar M7VIB.
> 
> If I read you correctly you're getting random corruptions all over the
> place so there isn't much you an do.

As far as I read him, he wants to build a kernel that runs on his new
board as well as on his old board.

Basically, he has to just compile a kernel that includes hardware
support for both chipsets, and all of the other hardware that is on the
boards. For processor selection, he should find the best compromise
between both processors (so try to select one that has all features that
both real processors have in common), and he might try the generic X86
optimizations, too.

HTH,
Markus


-- 
markus schaber | dipl. informatiker
logi-track ag | rennweg 14-16 | ch 8001 zürich
phone +41-43-888 62 52 | fax +41-43-888 62 53
mailto:schabios@logi-track.com | www.logi-track.com
