Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUHFOEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUHFOEk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUHFOEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:04:40 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:32917 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S265971AbUHFOEg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:04:36 -0400
Date: Fri, 6 Aug 2004 15:04:26 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Mark Lord <lkml@rtr.ca>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata: dma, io error messages
In-Reply-To: <41138C67.7040306@rtr.ca>
Message-ID: <Pine.LNX.4.60.0408061453410.2622@fogarty.jakma.org>
References: <Pine.LNX.4.60.0408061113210.2622@fogarty.jakma.org>
 <1091795565.16307.14.camel@localhost.localdomain> <41138C67.7040306@rtr.ca>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004, Mark Lord wrote:

>>> Also, the drive is extremely slow now, about 1MB/s drive transfer rate 
>>> as reported by hdparm -T.

> That should read "hdparm -t", not "-T", right?

erk, sorry, yes.

> And the slowness is most likely due to the error recovery (retries) 
> in the drive and/or driver, which cause the overall throughput to 
> plummet for the measurement interval.

ah. There are no reported errors though. So presumably drive retries 
that end up being successful.

If that is so then this suggests the drive has a far more serious 
problem than just a single bad block, right?

> Cheers

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Nothing is ever a total loss; it can always serve as a bad example.
