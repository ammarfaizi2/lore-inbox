Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbUL1AcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbUL1AcI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 19:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbUL1AcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 19:32:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:3002 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262010AbUL1AcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 19:32:05 -0500
Date: Mon, 27 Dec 2004 16:29:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adam Sampson <azz@us-lot.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: PATCH: (Discussion) Stop IDE legacy ISA probes on PCI systems
In-Reply-To: <y2a7jn34f4h.fsf@cartman.at.fivegeeks.net>
Message-ID: <Pine.LNX.4.58.0412271629270.2353@ppc970.osdl.org>
References: <1104156823.20898.21.camel@localhost.localdomain>
 <y2a7jn34f4h.fsf@cartman.at.fivegeeks.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Dec 2004, Adam Sampson wrote:
> 
> I don't think that code will have the intended effect, unless your
> GCC has some funny ideas about switch statements...

Indeed. That if-statement is unreachable and has no effect.

		Linus
