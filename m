Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130470AbRDCQOo>; Tue, 3 Apr 2001 12:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRDCQOg>; Tue, 3 Apr 2001 12:14:36 -0400
Received: from web5203.mail.yahoo.com ([216.115.106.97]:33298 "HELO
	web5203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130470AbRDCQO1>; Tue, 3 Apr 2001 12:14:27 -0400
Message-ID: <20010403161345.15009.qmail@web5203.mail.yahoo.com>
Date: Tue, 3 Apr 2001 09:13:45 -0700 (PDT)
From: Rob Landley <telomerase@yahoo.com>
Subject: Re: Original destination of transparent proxied connections? 
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m14jf1U-001PKaC@mozart>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Rusty Russell <rusty@rustcorp.com.au> wrote:
> Summary: you had to use a *search engine* to find an
> obscure piece of
> coding information.

Actually, I had to use a search engine to find a
tangentially related howto that halfway through
mentioned something in passing which gave me a clue of
something else to search for that, it turns out,
didn't work anyway.  (getsockname() in 2.2 returns the
original destination ip, but not the original
destination port.  I had to move to
2.4/netfilter/getsockopt to get that piece of
information.)

And the reason I didn't ask on the netfilter list is I
was originally trying to use 2.2 ipchains, not 2.4
iptables.  Didn't think the old stuff was on-topic
there.

> Shocked!
> Rusty.

It still requires pretty good forensic investigation
skills to make it work...

> Premature optmztion is rt of all evl. --DK

Wouldn't that be "Premtur"? :)

Rob


__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
