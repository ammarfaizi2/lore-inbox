Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135648AbRDTHKi>; Fri, 20 Apr 2001 03:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135656AbRDTHKS>; Fri, 20 Apr 2001 03:10:18 -0400
Received: from zeus.kernel.org ([209.10.41.242]:7105 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135648AbRDTHJi>;
	Fri, 20 Apr 2001 03:09:38 -0400
Message-ID: <3ADFD7A3.67EE00AE@mandrakesoft.com>
Date: Fri, 20 Apr 2001 02:30:59 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: Roberto Nibali <ratz@tac.ch>, linux-kernel@vger.kernel.org,
        Donald Becker <becker@scyld.com>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <Pine.LNX.4.33.0104192241060.4771-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> Well.. Space.c is a dinozaur. However, this is the 2.2 series and no more
> surgery will happen on this kernel, at least normally.
> 
> Have you tried loading the drivers as modules? You might have more luck
> with that approach. Space.c was designed at a time when having 4 NIC's in
> a PC was "pushing the limits"...

2.2.recent has module_init/exit, so you don't even need Space.c.

-- 
Jeff Garzik       | "The universe is like a safe to which there is a
Building 1024     |  combination -- but the combination is locked up
MandrakeSoft      |  in the safe."    -- Peter DeVries
