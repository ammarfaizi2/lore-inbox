Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135652AbRDTHKh>; Fri, 20 Apr 2001 03:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135648AbRDTHKT>; Fri, 20 Apr 2001 03:10:19 -0400
Received: from cs.columbia.edu ([128.59.16.20]:46551 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S135652AbRDTHJ5>;
	Fri, 20 Apr 2001 03:09:57 -0400
Date: Fri, 20 Apr 2001 00:09:48 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Roberto Nibali <ratz@tac.ch>, <linux-kernel@vger.kernel.org>,
        Donald Becker <becker@scyld.com>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <3ADFD7A3.67EE00AE@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0104200009130.5144-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2001, Jeff Garzik wrote:

> > Have you tried loading the drivers as modules? You might have more luck
> > with that approach. Space.c was designed at a time when having 4 NIC's in
> > a PC was "pushing the limits"...
> 
> 2.2.recent has module_init/exit, so you don't even need Space.c.

Check again. drivers/net builds a .a, not a .o. Trust me, I've tried.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

