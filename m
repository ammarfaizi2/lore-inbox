Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293196AbSCKVtw>; Mon, 11 Mar 2002 16:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293258AbSCKVtm>; Mon, 11 Mar 2002 16:49:42 -0500
Received: from 1Cust36.tnt6.lax7.da.uu.net ([67.193.244.36]:15861 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S293196AbSCKVtb>; Mon, 11 Mar 2002 16:49:31 -0500
Subject: Re: [PATCH] 2.5.6 IDE 19
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 11 Mar 2002 13:50:52 -0800 (PST)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <E16kT8L-00014f-00@the-village.bc.nu> from "Alan Cox" at Mar 11, 2002 04:58:49 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020311215052.3D29F8954A@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > For gods sake:
> > 
> > 1. How is Win2000 going to work then?
> 
> Because its standards compliant. It wasnt written by a half clued wannabe
> who has never read the manuals and can do nothing but call people who have
> a "liar". And a standards compliant implementation does all the right power
> management commands. Win 98 didnt quite get it right and you'll find one
> of the updates addresses IDE problems. Ironically fixing the same flush
> cache and shut down politely problem you plan to break in Linux

Windows 2000 doesn't even get this right 100% of the time either:
http://support.microsoft.com/default.aspx?scid=kb;EN-US;q281672
(I've seen this bug corrupt data in real life -- it's not just
theoretical. The really unfortunate part is that Win2K also forces the
write cache on, even if you try to turn it off, due to another bug.)

AFAIK a fix for this is planned for Win2K Service Pack 3, and WinXP works
properly (in this regard anyway) out-of-the-box.

-Barry K. Nathan <barryn@pobox.com>
