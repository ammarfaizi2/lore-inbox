Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263292AbRFFOhk>; Wed, 6 Jun 2001 10:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263311AbRFFOha>; Wed, 6 Jun 2001 10:37:30 -0400
Received: from cloven-ext.nks.net ([216.139.204.130]:51990 "EHLO
	homer.mkintl.com") by vger.kernel.org with ESMTP id <S263292AbRFFOhV>;
	Wed, 6 Jun 2001 10:37:21 -0400
Message-ID: <3B1E401A.CC0598D1@illusionary.com>
Date: Wed, 06 Jun 2001 10:37:14 -0400
From: Derek Glidden <dglidden@illusionary.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Pringlemeir <bpringle@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com> <m2lmn61ceb.fsf@sympatico.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Pringlemeir wrote:
> 
> [snip]
>  Derek> overwhelmed.  On the system I'm using to write this, with
>  Derek> 512MB of RAM and 512MB of swap, I run two copies of this
> 
> Please see the following message on the kernel mailing list,
> 
> 3086:Linus 2.4.0 notes are quite clear that you need at least twice RAM of swap
> Message-Id: <E155bG5-0008AX-00@the-village.bc.nu>

Yes, I'm aware of this.

However, I still believe that my original problem report is a BUG.  No
matter how much swap I have, or don't have, and how much is or isn't
being used, running "swapoff" and forcing the VM subsystem to reclaim
unused swap should NOT cause my machine to feign death for several
minutes.

I can easily take 256MB out of this machine, and then I *will* have
twice as much swap as RAM and I can still cause the exact same
behaviour.

It's a bug, and no number of times saying "You need twice as much swap
as RAM" will change that fact.

-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
