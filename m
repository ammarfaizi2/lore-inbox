Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269040AbRHBPek>; Thu, 2 Aug 2001 11:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268977AbRHBPea>; Thu, 2 Aug 2001 11:34:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43282 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268972AbRHBPeV>; Thu, 2 Aug 2001 11:34:21 -0400
Subject: Re: [RFT] Support for ~2144 SCSI discs
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Thu, 2 Aug 2001 16:31:21 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dougg@torque.net (Douglas Gilbert),
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <no.id> from "Richard Gooch" at Aug 02, 2001 09:13:23 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SKRV-0000tY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > kmalloc with GFP_KERNEL has a 128K limit which avoids the bizarre
> > behaviour you get when you abuse get_free_pages.
> 
> Last I heard, get_free_pages() also has a 128 kiB limit. So what's the
> difference?

get_free_pages doesnt have such a limit. Thats why sg had the problem it did
