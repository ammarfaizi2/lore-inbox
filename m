Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265960AbUHFNle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbUHFNle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUHFNle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:41:34 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:26760 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S265960AbUHFNk7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:40:59 -0400
Date: Fri, 6 Aug 2004 14:40:48 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata: dma, io error messages
In-Reply-To: <1091795565.16307.14.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0408061438090.2622@fogarty.jakma.org>
References: <Pine.LNX.4.60.0408061113210.2622@fogarty.jakma.org>
 <1091795565.16307.14.camel@localhost.localdomain>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004, Alan Cox wrote:

>> Additional sense: Unrecovered read error - auto reallocate failed
>
> Bad block, and sufficiently bad that it couldn't then recover the block
> and rewrite it. When a drive sees a marginal read (lot of forward error
> correction recovery needed) it will try and rewrite or move the block.
>
> In this case it couldn't read the block enough to move it.

Ouch.

I've contacted my supplier to replace the disk. Kudo's to Neil Brown 
for mdadm - I had an email waiting for me this morning to tell me 
about the failed disk.

Thanks Alan.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Windows 95 has been operating for 2 hours, 32 minutes. No errors reported. CALL
GUINESS BOOK OF WORLD RECORDS NOW!
