Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135845AbRDTKFm>; Fri, 20 Apr 2001 06:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135846AbRDTKFc>; Fri, 20 Apr 2001 06:05:32 -0400
Received: from cs.columbia.edu ([128.59.16.20]:49798 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S135845AbRDTKFX>;
	Fri, 20 Apr 2001 06:05:23 -0400
Date: Fri, 20 Apr 2001 03:05:17 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Roberto Nibali <ratz@tac.ch>, <linux-kernel@vger.kernel.org>,
        Donald Becker <becker@scyld.com>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <3AE00814.10A87766@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0104200301380.5165-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2001, Jeff Garzik wrote:

> Sorry, I was talking about a local patch not a global patch.  If a user
> must patch their 2.2 kernel to get the starfire driver working anyway,
> then adding a change to do s/.a/.o/ on Makefiles would be simple.

People don't need to patch *anything* to get the starfire driver working --
it's included in 2.2.19 and working rather well I might add. :-)

This was a special case, which btw had nothing to do with the starfire 
driver itself. The user needed to support more than 8 eth ports, which 
2.2 complains about, and more than 16 eth ports, which 2.2 simply doesn't 
allow without further changes.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

