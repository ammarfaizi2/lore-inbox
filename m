Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279467AbRKASVL>; Thu, 1 Nov 2001 13:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279470AbRKASVB>; Thu, 1 Nov 2001 13:21:01 -0500
Received: from toad.com ([140.174.2.1]:63246 "EHLO toad.com")
	by vger.kernel.org with ESMTP id <S279467AbRKASUv>;
	Thu, 1 Nov 2001 13:20:51 -0500
Message-ID: <3BE19258.2E35EE3C@mandrakesoft.com>
Date: Thu, 01 Nov 2001 13:20:08 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Stress testing 2.4.14-pre6
In-Reply-To: <Pine.LNX.4.33.0111010903280.11617-100000@penguin.transmeta.com> <3BE18402.9F958EDC@mandrakesoft.com> <20011101191521.H3265@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Thu, Nov 01 2001, Jeff Garzik wrote:
> > Linus Torvalds wrote:
> > > Anyway, I seriously doubt this explains any real-world bad behaviour: the
> > > window for the interrupt hitting a half-way updated list is something like
> > > two instructions long out of the whole memory freeing path. AND most
> > > interrupts don't actually do any allocation.
> >
> > Network Rx interrupts do....  definitely not as frequent as IDE
> > interrupts, but not infrequent.
> 
> Which IDE interrupts allocate memory?!

Sorry, I meant as in, IDE interrupts occur more frequently than Rx
interrupts.

English is my first language... really.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
