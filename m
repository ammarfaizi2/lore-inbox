Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136586AbREAH3o>; Tue, 1 May 2001 03:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136585AbREAH3d>; Tue, 1 May 2001 03:29:33 -0400
Received: from cs.columbia.edu ([128.59.16.20]:58567 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S136587AbREAH3N>;
	Tue, 1 May 2001 03:29:13 -0400
Date: Tue, 1 May 2001 00:29:10 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19 locks up on SMP
In-Reply-To: <E14uUZX-0001GJ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0105010026530.12259-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001, Alan Cox wrote:

> Ok the main candidates there would be:
> 
> 	The sunrpc/nfs changes

I'm currently testing this one -- just preparing to reboot pre9 + these 
changes.

> 	EEpro100/starfire

eepro100 is in use. But that patch is harmless.

> 	aic7xxx

Loaded but not used, no devices attached to it.

Right now I'm pretty sure it's the NFS/SunRPC changes, but I'll know for 
sure in about 30 minutes.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

