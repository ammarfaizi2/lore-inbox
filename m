Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264690AbSKJDvX>; Sat, 9 Nov 2002 22:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264707AbSKJDvX>; Sat, 9 Nov 2002 22:51:23 -0500
Received: from dp.samba.org ([66.70.73.150]:38793 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264690AbSKJDvW>;
	Sat, 9 Nov 2002 22:51:22 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dipankar Sarma <dipankar@gamebox.net>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Re: UP went into unexpected trashing 
In-reply-to: Your message of "Fri, 08 Nov 2002 20:40:00 -0800."
             <Pine.LNX.4.44.0211082038580.1609-100000@home.transmeta.com> 
Date: Sun, 10 Nov 2002 14:09:22 +1100
Message-Id: <20021110035807.9E0B22C28F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0211082038580.1609-100000@home.transmeta.com> you wri
te:
> 
> On Sat, 9 Nov 2002, Rusty Russell wrote:
> > + * containing the bit) or a value >= size if none found.
> 
> However, what was the original codepath that doesn't follow this and was 
> the cause of the headache (ie the "unexpected trashing"?) 

It was the "cpu masks become an unsigned long array" patch, which was
in Andrew Morton's mm tree, but you never took.

> Let's fix that user of the functions too, not just the documentation..

You're not adopting the Viro doctine are you?  "On each new issue,
begin by assuming your peers are idiots". 8)

It's not becoming,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
