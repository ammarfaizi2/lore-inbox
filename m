Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313924AbSDPWRB>; Tue, 16 Apr 2002 18:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313925AbSDPWRA>; Tue, 16 Apr 2002 18:17:00 -0400
Received: from bitsorcery.com ([161.58.175.48]:23311 "EHLO bitsorcery.com")
	by vger.kernel.org with ESMTP id <S313924AbSDPWQ7>;
	Tue, 16 Apr 2002 18:16:59 -0400
From: Albert Max Lai <amlai@bitsorcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15548.41687.486102.179631@bitsorcery.com>
Date: Tue, 16 Apr 2002 22:16:55 +0000
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x and DAC960 issues
In-Reply-To: <20020406182101.GA27414@glamis.bard.org.il>
X-Mailer: VM 7.01 under Emacs 20.4.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the summary of the off-list discussion and solution to my
DAC960 problem.

-Albert

On Saturday, 6 April 2002, Marc A. Volovic wrote:

> Quoth Leonard N. Zubkoff:
> 
> >   From: Albert Max Lai <amlai@bitsorcery.com>
> > 
> >   I moved the card into the slot closest to the CPU that I could, and
> >   voila!  everything works correctly; no lockups, ext3 works, even
> > 
> > Excellent news.  That's not a fix I've heard of before.
> 
> Hi,
> 
> Alas, it is very simple. Many (most? in my experience - Tyan, MSI, ASUS)
> motherboards leave their outer (farthest from the CPU area) PCI slots 
> ___NON-bus mastering___. In most cases, this is the outermost slot, but
> sometimes it is more than one slot, but again, the outermost, leftmost.
> 
> Sometimes, the masterlessness is dynamic - i.e. based on the number of
> populated slots, counting from the CPU. This is EXTREMELY rare. I saw
> it only once, I think, and on a board I did not trust even as far as 
> I could toss it. (Well, I could toss it some reasonable distance, which
> I did ;-)...
> 
> In some rare cases (errrr... ummmm... SOME Tyan board, I cannot
> currently remember the model) ran in the reverse direction.
> 
> Populating these masterless slots with anything but a sound card (and in
> many cases even by a sound card) leads to loss of stability. 
> 
> Moving a board INWARD (i.e. toward the CPU) in many cases solves the
> problem.
> 
> -- 
> ---MAV
>                        Linguists Do It Cunningly
> Marc A. Volovic                                          marc@bard.org.il
