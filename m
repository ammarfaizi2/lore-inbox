Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136211AbRD0Uzc>; Fri, 27 Apr 2001 16:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136213AbRD0UzW>; Fri, 27 Apr 2001 16:55:22 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:48220 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S136211AbRD0UzK>; Fri, 27 Apr 2001 16:55:10 -0400
Message-ID: <3AE9DC22.597D94F5@sgi.com>
Date: Fri, 27 Apr 2001 13:52:50 -0700
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <200104271113.NAA16761@cave.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:

> > > On Linux any swap adds to the memory pool, so 1xRAM would be
> > > equivalent to 2xRAM with the old old OS's.
> >
> > no more true AFAIK
>
> I've always been trying to convice people that 2x RAM remains a good
> rule-of-thumb.

---
    Ug.  I like to view swap as "low grade memory" -- i.e. I really
should spend 99.9% of my time in RAM -- if I spill, then it means
I'm running too much/too big for my computer and should get more RAM --
meanwhile, I suffer with performance degradation to remind me I'm really
exceeding my machine's physical memory capacity.

    An interesting option (though with less-than-stellar performance
characteristics) would be a dynamically expanding swapfile.  If you're
going to be hit with swap penalties, it may be useful to not have to
pre-reserve something you only hit once in a great while.

    Definitely only for systems where you don't expect to use swap (but
it could be there for "emergencies" up to some predefined limit or
available disk space).

--
The above thoughts and           | They may have nothing to do with
writings are my own.             | the opinions of my employer. :-)
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338



