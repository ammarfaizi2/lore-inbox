Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277228AbRJDU6d>; Thu, 4 Oct 2001 16:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277226AbRJDU6N>; Thu, 4 Oct 2001 16:58:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54543 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277224AbRJDU5z>; Thu, 4 Oct 2001 16:57:55 -0400
Subject: Re: Whining about 2.5 (was Re: [PATCH] Re: bug? in using generic read/write functions to read/write block devices in 2.4.11-pre2)
To: landley@trommello.org
Date: Thu, 4 Oct 2001 22:02:38 +0100 (BST)
Cc: viro@math.psu.edu (Alexander Viro), hch@ns.caldera.de (Christoph Hellwig),
        linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <01100315551100.00728@localhost.localdomain> from "Rob Landley" at Oct 03, 2001 03:55:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pFde-0004A3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> question, I know), which VM will it use?  I'm guessing Alan will still 
> inherit the "stable" codebase, but the -ac and -linus trees are breaking new 
> ground on divergence here.  Which tree becomes 2.4 once Alan inherits it?  
> (Is this part of what's holding up 2.5?)

For the moment I plan to maintain the 2.4.*-ac tree. I don't know what will
happen about 2.4 longer term - that is a Linus question. Looking at
historical VM history I don't think we will eliminate enough "2.4.10+ oops
on my box" and "on this load the VM sucks" cases from 2.4.10 to fairly 
review Andrea's VM until Linus has done another 5 or 6 releases and the VM
has been tuned, bugs removed and other oops cases proven not to be vm
triggered.

Alan
