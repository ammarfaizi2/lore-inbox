Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261930AbTCHAg0>; Fri, 7 Mar 2003 19:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261949AbTCHAg0>; Fri, 7 Mar 2003 19:36:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49413 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261930AbTCHAgZ>; Fri, 7 Mar 2003 19:36:25 -0500
Message-ID: <3E693D65.8060308@zytor.com>
Date: Fri, 07 Mar 2003 16:46:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv> <Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com> <20030307233916.Q17492@flint.arm.linux.org.uk> <3E692EE4.9020905@zytor.com> <Pine.LNX.4.44.0303080116500.32518-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0303080116500.32518-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> But before it's actually merged, I would slowly really like to know the 
> reasoning for license. You completely avoid that question and that makes
> me nervous.
>

Actually I don't, you just don't like to hear the answer.  I believe I
have stated and restated this several times already.

>
> Why did you choose this license over any GPL variant?
> We could as well integrate dietlibc and if anyone has a problem with it, 
> he can still choose your klibc.
> Why should I contribute to klibc instead of dietlibc?
> 

One more time, with feeling...

a) I, as well as the other early userspace developers, feel that the
advantages of allowing linking nonfree applications outweigh the
disadvantages.

b) I will personally go batty if I ever have to create yet another
implementation of printf() and the few other things in klibc that is
anything other than a thin shim over the kernel interface.  The bottom
line is that klibc is so Linux-specific, that the only way someone would
"steal" code from it is because they want a specific subroutine
somewhere, and as far as I'm concerned, they can have it, and I don't
care in the slightest for what project.

	-hpa


