Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277502AbRJERFO>; Fri, 5 Oct 2001 13:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277486AbRJERE7>; Fri, 5 Oct 2001 13:04:59 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60935 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277503AbRJEREk>; Fri, 5 Oct 2001 13:04:40 -0400
Subject: Re: 3ware discontinuing the Escalade Series
To: Ryan@srfarms.com (Ryan C. Bonham)
Date: Fri, 5 Oct 2001 18:10:11 +0100 (BST)
Cc: lm@bitmover.com (Larry McVoy),
        alan@lxorguk.ukuu.org.uk ("Alan Cox (E-mail)"),
        linux-kernel@vger.kernel.org
In-Reply-To: <19AB8F9FA07FB0409732402B4817D75A038B63@FILESERVER.SRF.srfarms.com> from "Ryan C. Bonham" at Oct 05, 2001 12:49:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pYUF-00071y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The Adaptec 2400A IDE Raid Cards work under Linux, although you will need to
> patch your kernel, the patch is available from Adaptec's website. 

Adaptec have released complete source code ?

> It seems like work was being done to add support for the Promise RAID cards,
> it seems like Alan had support in his tree, I might be wrong about that
> though. Alan?

We have partial promise and hpt support for their softraid in the -ac tree
and the basics pushed into Linus tree. Andre and Promise have sorted out
full access to promise info on this so we should see full promise softraid
support.

The Promise hardware raid (Supertrak100) is also supported in the ac and
Linus trees nowdays but I've never been happy with its price/performance 
personally.

Alan
