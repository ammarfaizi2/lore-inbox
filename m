Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270449AbRHHK5y>; Wed, 8 Aug 2001 06:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270450AbRHHK5o>; Wed, 8 Aug 2001 06:57:44 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45831 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270449AbRHHK53>; Wed, 8 Aug 2001 06:57:29 -0400
Subject: Re: How does "alias ethX drivername" in modules.conf work?
To: rhw@MemAlpha.CX (Riley Williams)
Date: Wed, 8 Aug 2001 11:59:06 +0100 (BST)
Cc: jdwyatt@Bellsouth.net (Josh Wyatt), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0108080705450.12565-100000@infradead.org> from "Riley Williams" at Aug 08, 2001 07:28:55 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UR3K-00051r-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Why not have a provision like the following:
> 
>  > 1. For a given driver, assign ethX in [ascending|descending]
>  >    (pick one) order based on MAC addr. At least this is a
>  >    predictable order; it should never change for a given driver.
> 
> Alan Cox will correct me if I'm wrong, but memory says that he pointed
> out a while back some problem with this idea. I've cc'd this to him
> for comments.

Correct. MAC addresses are defined per machine not per card. That they tend
to be per card is on a PC isnt always true elsewhere. For example many sparc
boxes have one mac per machine.

Its still a valuable way of naming devices. 
