Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292668AbSCDSff>; Mon, 4 Mar 2002 13:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292666AbSCDSf1>; Mon, 4 Mar 2002 13:35:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34824 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292678AbSCDSfI>; Mon, 4 Mar 2002 13:35:08 -0500
Subject: Re: [RFC] Arch option to touch newly allocated pages
To: jdike@karaya.com (Jeff Dike)
Date: Mon, 4 Mar 2002 18:49:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200203041836.NAA03308@ccure.karaya.com> from "Jeff Dike" at Mar 04, 2002 01:36:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hxWu-0000Bc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > alloc_pages is only called at the time the backing page is created -
> > by then it doesnt matter - its too late.
> 
> *My* (i.e. the one inside UML) alloc_pages, not the host's would do the
> dirtying.  That's the whole point.  The UML alloc_pages would make sure
> that the pages it hands out are backed on the host before they are handed
> out to the rest of UML.

Ok got you - so its merely grossly ineffecient and downright rude to
other users of the system ?
