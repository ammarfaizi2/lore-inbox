Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135840AbRDTJuU>; Fri, 20 Apr 2001 05:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135842AbRDTJuK>; Fri, 20 Apr 2001 05:50:10 -0400
Received: from cs.columbia.edu ([128.59.16.20]:20868 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S135840AbRDTJuA>;
	Fri, 20 Apr 2001 05:50:00 -0400
Date: Fri, 20 Apr 2001 02:49:50 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Roberto Nibali <ratz@tac.ch>, <linux-kernel@vger.kernel.org>,
        Donald Becker <becker@scyld.com>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <3ADFE5B7.C9CA1F9E@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0104200244000.5165-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2001, Jeff Garzik wrote:

> > Check again. drivers/net builds a .a, not a .o. Trust me, I've tried.
> 
> Sure, but if you are patching anyway, it much better to fix that than
> hack space.c :)

Well, I remember asking Alan if he'd prefer it done that way, and not 
getting a reply back. So I didn't press further.

The change to support __init/__exit in drivers/net is a no-brainer, and I 
did test it at the time -- it worked as expected. But it's really up to 
Alan to decide, I couldn't care less to be quite honest.

In a way I think I understand why he's reluctant: it's very easy to end up
changing the initialization order by mistake and messing up people's 
network setups.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

