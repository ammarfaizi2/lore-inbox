Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267800AbUHEQxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267800AbUHEQxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267809AbUHEQw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:52:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:37274 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267800AbUHEQus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:50:48 -0400
Date: Thu, 5 Aug 2004 09:50:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
cc: Fruhwirth Clemens <clemens@endorphin.org>,
       James Morris <jmorris@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.6.8-rc3 - BSD licensing
In-Reply-To: <411228FF.485E4D07@users.sourceforge.net>
Message-ID: <Pine.LNX.4.58.0408050941590.24588@ppc970.osdl.org>
References: <Xine.LNX.4.44.0408041156310.9291-100000@dhcp83-76.boston.redhat.com>
   <1091644663.21675.51.camel@ghanima> <Pine.LNX.4.58.0408041146070.24588@ppc970.osdl.org>
   <1091647612.24215.12.camel@ghanima> <Pine.LNX.4.58.0408041251060.24588@ppc970.osdl.org>
 <411228FF.485E4D07@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Aug 2004, Jari Ruusu wrote:
> 
> Most of the files in loop-AES are licensed under GPL. Some files have less
> restrictive license, but are still licensed under GPL-compatible license.
> I am not aware of any files in loop-AES that are GPL-incompatible.

You're saying that you consider Gladman's original AES license to be
GPL-compatible (ie a subset of it)? That's fine - apparently the FSF
agrees.

However, that is incompatible with you then complaining when it gets 
released under the GPL. If the original license was a proper subset of the 
GPL, then it can _always_ be re-released under the GPL, and you don't have 
anything to complain about.

So which is it? Either it's GPL-compatible or it isn't. If it is
GPL-compatible, why are you making noises? And if it is not, why are you
claiming that you can distribute loop-AES as a GPL'd project?

You seem to be very very confused, Jari. There really _are_ only these two 
cases:

 - the AES code is GPL-compatible

   This fundamentally means that it has no more restrictions than the GPL, 
   and that in turn means that it can always be re-licensed as GPL'd code. 
   Which James Morris did (well, it was dual-licensed, but the only 
   license that matters for the _kernel_ is the GPL).

   In this case, you can't say "you can't do that". I'm sorry, but James 
   _can_ do that, and it is _you_ who can't do that. 

 - the AES code is _not_ GPL compatible.

   This fundamentally means that you can't relicense it under the GPL, but 
   it _also_ means that you can't link it with GPL code, since the GPL
   _requires_ that the code be under the GPL. In this case, loop-AES was 
   always wrogn and lying about beign GPL'd, and you should stop
   distributing it immediately.

You can't have it both ways. And there aren't any third alternatives.

Explain yourself.

		Linus

