Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262686AbRFYIuo>; Mon, 25 Jun 2001 04:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262694AbRFYIuZ>; Mon, 25 Jun 2001 04:50:25 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:20755 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S262686AbRFYIuS>;
	Mon, 25 Jun 2001 04:50:18 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Annoying kernel behaviour
Date: 25 Jun 2001 07:41:56 GMT
Organization: [x] network byte order
Message-ID: <slrn9jdqq4.3af.kraxel@bytesex.org>
In-Reply-To: <3B33EFC0.D9C930D5@bigfoot.com>    <9h0r6s$fe7$1@ns1.clouddancer.com>    <20010623090542.6019D7846F@mail.clouddancer.com>    <3B35C2FA.37F57964@bigfoot.com> <9h4ft5$1ku$1@ns1.clouddancer.com>    <20010624114655.3D187784C4@mail.clouddancer.com> <3B3643A8.F3FE1E92@bigfoot.com> <9h5gbc$3mb$1@ns1.clouddancer.com> <20010625032231.930C8784C4@mail.clouddancer.com>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 993454916 3408 127.0.0.1 (25 Jun 2001 07:41:56 GMT)
User-Agent: slrn/0.9.7.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >There are no conflicts, and PCI should be able to share anyways.
>  
>  That's the theory now for some time, has never worked.  Even hacking
>  the SCSI driver, any attempted IRQ sharing kills my systems.  Even my
>  quad ethernet is not successful at sharing IRQs with itself, in 2+ very
>  different motherboards.

For bttv I know that irq sharing works in some cases and not on others.
Last not-working report was bttv sharing with a nvidia.  Moving the
grabber board to another PCI slot (nvidia having a exclusive irq then,
bttv shared the irq with something else) fixed it.

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
