Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267819AbUHaV24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267819AbUHaV24 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUHaV01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:26:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:22672 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267819AbUHaVZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:25:56 -0400
Date: Tue, 31 Aug 2004 14:25:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Frank van Maarseveen <frankvm@xs4all.nl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tom Vier <tmv@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040831211331.GA27746@janus>
Message-ID: <Pine.LNX.4.58.0408311423280.2295@ppc970.osdl.org>
References: <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy>
 <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org>
 <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org>
 <20040831033950.GA32404@zero> <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org>
 <1093949876.32682.1.camel@localhost.localdomain> <Pine.LNX.4.58.0408311006340.2295@ppc970.osdl.org>
 <20040831211331.GA27746@janus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Aug 2004, Frank van Maarseveen wrote:
> 
> There is nothing in the networking or UNIX standards that prescibe another
> protection domain for this. Would be insane to leave that out in a hosted
> environment but it _can_ be done without.

My point is that TCP _does_ have a lot of state that needs to be handled 
in a safe manner by a proper operating system.

The fact that there are OS's out there that are crap doesn't change that 
matter. There are lots of embedded OS's out there that still do 
multitasking in a purely cooperative way. I don't think it's a valid model 
for anything but toys. Same goes for putting TCP in user space. It's 
doable, but it's not an "OS". It's a program loader.

		Linus
