Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292476AbSCDQhJ>; Mon, 4 Mar 2002 11:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292481AbSCDQg7>; Mon, 4 Mar 2002 11:36:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2567 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292476AbSCDQgu>; Mon, 4 Mar 2002 11:36:50 -0500
Subject: Re: HPT372 on KR7A-RAID
To: lkml@andyjeffries.co.uk (Andy Jeffries)
Date: Mon, 4 Mar 2002 16:51:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020304154007.62716a6c.lkml@andyjeffries.co.uk> from "Andy Jeffries" at Mar 04, 2002 03:40:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hvgh-0008G6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At least, the array of HPT chipsets doesn't have the 372 entry.  Does it
> fix it neatly (if the index of the revision is above the array label it as
> unknown)?

Yep

> It doesn't seem to as line 225 in drivers/ide/hpt366.c seems to just use
> class_rev as an index in to the chipset_names array (which will bomb out
> it it tries to access class_rev=5).

I'll check that one. Arjan fixed ide-pci. There may be one that isnt fixed
in the -ac tree. I'm not suprised the base tree doesnt work tho
