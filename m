Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286942AbSA1WQQ>; Mon, 28 Jan 2002 17:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSA1WP5>; Mon, 28 Jan 2002 17:15:57 -0500
Received: from dsl-213-023-039-090.arcor-ip.net ([213.23.39.90]:2439 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286942AbSA1WPz>;
	Mon, 28 Jan 2002 17:15:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Momchil Velikov <velco@fadata.bg>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Mon, 28 Jan 2002 23:19:46 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
In-Reply-To: <Pine.LNX.4.33.0201281005480.1609-100000@penguin.transmeta.com> <E16VHy5-0000Bz-00@starship.berlin> <87u1t6f83i.fsf@fadata.bg>
In-Reply-To: <87u1t6f83i.fsf@fadata.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VK7z-0000D6-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 28, 2002 11:01 pm, Momchil Velikov wrote:
> >>>>> "Daniel" == Daniel Phillips <phillips@bonn-fries.net> writes:
> 
> Daniel> I'd cheerfully hand this coding effort off to someone more familiar with this 
> Daniel> particular neck of the kernel woods - you, Davem and Marcelo come to mind, 
> Daniel> but if nobody bites I'll just continue working on it at my own pace.  I 
> 
> BTW, I'm doing just this, working on it at my own pace. 

Right, well in a couple of days we can compare notes.  I'm a little
embarrassed at the state of the code as of today, I think I'm interpreting
some of those ulongs as things they shouldn't be.

This would be a whole lot easier if those ugly macros in pgtable.h were inlines
with pagetable_t etc. parameters instead.

-- 
Daniel
