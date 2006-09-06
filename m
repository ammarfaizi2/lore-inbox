Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWIFFCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWIFFCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 01:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWIFFCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 01:02:34 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:55691 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932091AbWIFFCd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 01:02:33 -0400
Message-ID: <44FE5668.4090000@drzeus.cx>
Date: Wed, 06 Sep 2006 07:02:32 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, Alex Dubov <oakad@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash
 card readers
References: <20060902085343.93521.qmail@web36708.mail.mud.yahoo.com> <44F967E8.9020503@drzeus.cx> <20060902094818.49e5e1b1.akpm@osdl.org> <44F9EE86.4020500@drzeus.cx> <20060903034836.GB6505@kroah.com> <44FAA61F.9000504@drzeus.cx> <20060905191241.GA18427@kroah.com> <44FDD94E.7060701@drzeus.cx> <20060906033347.GE7886@kroah.com>
In-Reply-To: <20060906033347.GE7886@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> But there is no "subsystem" for a memory card reader, right?  That's one
> of the problems here :)
>   

There is for the MMC portion. And MemoryStick will probably get one next.

> I don't know, but misc/ is fine with me unless someone else has a good
> idea of where to put it.
>   

I was more interested in if the Kconfig select scheme seemed reasonable.
If so, then Alex can start transforming his code into a patch against
the current tree.

Rgds
Pierre

