Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132615AbRDGIfQ>; Sat, 7 Apr 2001 04:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132616AbRDGIfG>; Sat, 7 Apr 2001 04:35:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28426 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132615AbRDGIex>; Sat, 7 Apr 2001 04:34:53 -0400
Subject: Re: 2.4.3 tcp window id causes problems talking to windows clients
To: kstone@trivergent.net (Kevin Stone)
Date: Sat, 7 Apr 2001 09:36:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3ACE14EA.2030502@trivergent.net> from "Kevin Stone" at Apr 06, 2001 03:11:38 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14loDB-0007Bp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> to be working quite well (except for the lack of swap reclamation-- I 
> appreciate the reasoning, but it makes upgrading older machines very 
> difficult.)  However, I would rather, for maintenance and sanity 

-ac will acquire swap cache reclaim in time, dunno about Linus tree but
I assume it will once it has 0 cost on hot paths. Right now there are
serious 2.4 vm correctness issues to fix first.

> Is there any plan to include the zerocopy patches into the stock kernel? 
>   The win2k dial-up/window id problem is really a showstopper but hasn't 
> generated much traffic on lkml or the digests. 
> 

I'd hope so. The binfmt_misc and file size security holes that are fixed
in -ac I also want to try and push to Linus for 2.4.4
