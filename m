Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUFSOtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUFSOtn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 10:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUFSOtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 10:49:43 -0400
Received: from tor.morecom.no ([64.28.24.90]:25204 "EHLO tor.morecom.no")
	by vger.kernel.org with ESMTP id S263893AbUFSOtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 10:49:41 -0400
Subject: Re: mode data=journal in ext3. Is it safe to use?
From: Petter Larsen <pla@morecom.no>
To: Ken Ryan <linuxryan@leesburg-geeks.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40D1B110.7020409@leesburg-geeks.org>
References: <40D1B110.7020409@leesburg-geeks.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1087656575.1769.243.camel@pla.lokal.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 19 Jun 2004 16:49:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > We are using ext3 on a compact flash disk in an embedded device. So we
> > are not using RAID systems.
> 

> Um, is this a new application or have you done this before?
> 
> It's my understanding that very few (or no) CF devices do wear-levelling internally.
> Using a journal, especially a true data journal, seems like *the* way to wear out your
> flash as quickly as possible.
> 
> If you've had success using ext2 in read/write mode on flash/CF in a shipping product,
> I for one would like to know more details!
> 
> 		ken

>From our data sheet:

    Wear Leveling is an intrinsic part of the operation of 	
    SanDisk products using NAND memory.

But for sure, we will use a Compact flash that DO wear leveling, and
also shuffling read-only data around the Compact Flash disk.

This will be for production, yes.

Petter
