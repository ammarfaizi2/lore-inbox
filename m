Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751766AbWI1IHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbWI1IHL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 04:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWI1IHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 04:07:11 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:3490 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751766AbWI1IHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 04:07:07 -0400
Date: Thu, 28 Sep 2006 10:04:20 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergey Panov <sipan@sipan.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <Pine.LNX.4.64.0609271000510.3952@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0609280947360.21498@yvahk01.tjqt.qr>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> 
 <1159319508.16507.15.camel@sipan.sipan.org>  <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
  <1159342569.2653.30.camel@sipan.sipan.org>  <Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr>
 <1159359540.11049.347.camel@localhost.localdomain> <Pine.LNX.4.64.0609271000510.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>People don't have a clue!
>
>The GPLv2 never _ever_ mentions "linking" or any other technical measure 
>at all. Doing so would just be stupid (another problem with the GPLv3, 
>btw). So people who think that the GPLv2 disallows "linking" with 
>non-GPLv2 code had better go back and read the license again.
>
>Grep for it, if you want to. The word "link" simply DOES NOT EXIST IN THE 
>LICENSE!

Hah then read LICENSE.LGPL!

"""Most GNU software, including some libraries, is covered by the
ordinary GNU General Public License.  This license, the GNU Lesser
General Public License, applies to certain designated libraries, and
is quite different from the ordinary General Public License.  We use
this license for certain libraries in order to permit linking those
libraries into non-free programs."""

If the GPL does not mention linking at all, and therefore does not
really forbid it, why do we need an LGPL to allow linking then?

>What the GPLv2 actually talks about is _only_ about "derived work". And 
>whether linking (dynamically, statically, or by using an army of worker 
>gnomes that re-arrange the bits to their liking) means something is 
>"derived or not" is a totally different issue, and is not something you 
>can actually say one way or the other, because it will depend on the 
>circumstances.

I would be of the opinion that dynamic linking does not make it a
derived work, because neither the ld program nor the ld-linux.so
dynamic linker knows whether -lfoo is actually GPL or not.

>> No. The definition of a derivative work is a legal one and not a
>> technical one.

And that is a major problem IMHO. If there is no definitive
[technical] answer to what constitues a derived work, and it leaves
you at risk to lose a case in court while it is a gray area.

Oh well back on the topic: A userspace app just is not a derivate
work of the kernel, for me at least.


>Now, it is also indisputable that if you _need_ to "link", it's a damn 
>good sign that something is _very_likely_ to be derivative, but as Alan 
>points out, you could do the same thing with RPC over a socket, and the 
>fact that you did it technically differently really makes no real 
>difference. So linking per se isn't the issue, and never has been.

Jan Engelhardt
-- 
