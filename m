Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278125AbRKHUi1>; Thu, 8 Nov 2001 15:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278205AbRKHUiQ>; Thu, 8 Nov 2001 15:38:16 -0500
Received: from a59178.upc-a.chello.nl ([62.163.59.178]:30987 "EHLO
	www.unternet.org") by vger.kernel.org with ESMTP id <S278125AbRKHUiB>;
	Thu, 8 Nov 2001 15:38:01 -0500
Date: Thu, 8 Nov 2001 21:36:23 +0100
From: Frank de Lange <frank@unternet.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Frank de Lange <lkml-frank@unternet.org>, linux-kernel@vger.kernel.org
Subject: Re: hang with 2.4.14 & vmware 3.0.x, anyone else seen this?
Message-ID: <20011108213623.B11523@unternet.org>
In-Reply-To: <89EA9194B5B@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <89EA9194B5B@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Thu, Nov 08, 2001 at 09:08:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 09:08:10PM +0000, Petr Vandrovec wrote:
> Is it really solid freeze (what does alt-sysrq-s,u,s,b)? 

Solid as a rock, nothing responds anymore. You can sit an elephant on the
keyboard and it won't respond.

Only the big white switch helps (fsck'ing 80 gigs gives me enough time to make
a good cup of coffee... time for ext3 in the main kernel series...)

Have you investigated the problems any further? I mean, does it hang in the
vmware module (probably vmmon as it does not seem to be related to network or
other peripheral activity), or is it somewhere in the main kernel code?

 [ maybe I should give up and just install that kernel debugger... ]

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
