Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262345AbRERPnN>; Fri, 18 May 2001 11:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262349AbRERPnD>; Fri, 18 May 2001 11:43:03 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17677 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262345AbRERPmu>; Fri, 18 May 2001 11:42:50 -0400
Subject: Re: CML2 design philosophy heads-up
To: esr@thyrsus.com
Date: Fri, 18 May 2001 16:38:08 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), trini@kernel.crashing.org (Tom Rini),
        meissner@spectacle-pond.org (Michael Meissner),
        kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010518105353.A13684@thyrsus.com> from "Eric S. Raymond" at May 18, 2001 10:53:53 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150mKO-0007FF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. When we have a platform symbol for a reference design like MVME147, do 
>    we stick to its spec sheet or consider it representative of all derivatives
>    (which may have other facilities)?

At most it bounds the busses directly available. I've yet to see VME cardbus
adapters but its quite possible.

> I don't want to do (a); it conflicts with my design objective of
> simplifying configuration enough that Aunt Tillie can do it.  I won't 
> do that unless I see a strong consensus that it's the only Right Thing.

Its a good way of getting the defaults right. It may also be an appropriate
way of guiding presentation (eg putting the stuff the ruleset says you wont
have under a subcategory so you would see


		CPU type
		Devices
		blah
		blah
		Other Options
			IDE disk
			Cardbus


