Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135710AbRDTHbe>; Fri, 20 Apr 2001 03:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135731AbRDTHbN>; Fri, 20 Apr 2001 03:31:13 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39623 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135710AbRDTHbL>;
	Fri, 20 Apr 2001 03:31:11 -0400
Message-ID: <3ADFE5B7.C9CA1F9E@mandrakesoft.com>
Date: Fri, 20 Apr 2001 03:31:04 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: Roberto Nibali <ratz@tac.ch>, linux-kernel@vger.kernel.org,
        Donald Becker <becker@scyld.com>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <Pine.LNX.4.33.0104200009130.5144-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> 
> On Fri, 20 Apr 2001, Jeff Garzik wrote:
> 
> > > Have you tried loading the drivers as modules? You might have more luck
> > > with that approach. Space.c was designed at a time when having 4 NIC's in
> > > a PC was "pushing the limits"...
> >
> > 2.2.recent has module_init/exit, so you don't even need Space.c.
> 
> Check again. drivers/net builds a .a, not a .o. Trust me, I've tried.

Sure, but if you are patching anyway, it much better to fix that than
hack space.c :)

-- 
Jeff Garzik       | "The universe is like a safe to which there is a
Building 1024     |  combination -- but the combination is locked up
MandrakeSoft      |  in the safe."    -- Peter DeVries
