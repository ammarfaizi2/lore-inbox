Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268963AbRHPXM4>; Thu, 16 Aug 2001 19:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268981AbRHPXMq>; Thu, 16 Aug 2001 19:12:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46857 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268963AbRHPXMh>; Thu, 16 Aug 2001 19:12:37 -0400
Subject: Re: 2.4.9 does not compile [PATCH]
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Fri, 17 Aug 2001 00:14:05 +0100 (BST)
Cc: davem@redhat.com (David S. Miller), tpepper@vato.org, f5ibh@db0bm.ampr.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010816230719Z16545-1231+1256@humbolt.nl.linux.org> from "Daniel Phillips" at Aug 17, 2001 01:13:38 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XWKz-0006J6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The args and semantics of min/max changed to take
> > a type first argument,
> 
> They did?  This three argument min is butt-ugly, not to mention a completely 
> original way of expressing the idea that is very much in conflict with every 
> other expression of min I have ever seen.
> 
> What is wrong with using typeof?  If you must have a three argument min, 
> could it please be called "type_min" of similar.

It also doesnt solve all the cases. Basically its just ensuring everyone
doing portable code has to go and change all their macros to MIN and MAX
instead. Or use if statements, which with all the subtle suprises of
type casting is actually often a far far better idea and probably should
be encouraged a lot more in the kernel

Alan
