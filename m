Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272620AbRJETyH>; Fri, 5 Oct 2001 15:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272549AbRJETx5>; Fri, 5 Oct 2001 15:53:57 -0400
Received: from [194.213.32.137] ([194.213.32.137]:6016 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S271741AbRJETxp>;
	Fri, 5 Oct 2001 15:53:45 -0400
Date: Fri, 5 Oct 2001 20:51:37 +0200
From: Pavel Machek <pavel@Elf.ucw.cz>
To: Jeremy Elson <jelson@circlemud.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] FUSD v1.00: Framework for User-Space Devices
Message-ID: <20011005205136.A1272@elf.ucw.cz>
In-Reply-To: <20011002204836.B3026@bug.ucw.cz> <200110022237.f92Mbrk28387@cambot.lecs.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200110022237.f92Mbrk28387@cambot.lecs.cs.ucla.edu>
User-Agent: Mutt/1.3.22i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Sorry to follow-up to my own post.  A few people pointed out that
> >> v1.00 had some Makefile problems that prevented it from building.
> >> I've released v1.02, which should be fixed.
> >
> >This should be forwared to linmodem list... Killing all those
> >binary-only modem drivers from kernel modules would be good
> >thing... Hmm, and maybe we can just hack telephony API over ltmodem
> >and be done with that. That would be good.
[snip]
> Perhaps I don't understand how linmodems work to understand well
> enough how FUSD would apply - do you talk to linmodems through the
> serial driver?  If so, sounds like a good application - but we might

Yep. And linmodem driver does signal processing, so it is big and
ugly. And up till now, it had to be in kernel. With your patches, such
drivers could be userspace (where they belong!). Of course, it would be 
very good if your interface did not change...
								Pavel

