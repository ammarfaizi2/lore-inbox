Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263416AbRGNQn2>; Sat, 14 Jul 2001 12:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263334AbRGNQnS>; Sat, 14 Jul 2001 12:43:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58124 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263149AbRGNQm7>; Sat, 14 Jul 2001 12:42:59 -0400
Subject: Re: raid5d, page_launder and scheduling latency
To: andrewm@uow.edu.au (Andrew Morton)
Date: Sat, 14 Jul 2001 17:43:43 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), neilb@cse.unsw.edu.au (Neil Brown),
        mblack@csihq.com (Mike Black), linux-kernel@vger.kernel.org (lkml),
        ext2-devel@lists.sourceforge.net
In-Reply-To: <3B50765F.6ECF7B17@uow.edu.au> from "Andrew Morton" at Jul 15, 2001 02:42:07 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15LSW7-0001QO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - exit with 1,000 files open
> - exit with half a million pages to be zapped
> 
> And "fixing" copy_*_user is outright dumb.  Just fix the four
> or five places where it matters.

Depends if you want to use Linux as a Windows 3.1 replacement or a real OS.
In the latter case we need to fix the stupid cases too.

Alan

