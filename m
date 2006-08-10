Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161356AbWHJPeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161356AbWHJPeS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161357AbWHJPeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:34:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56759 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161356AbWHJPeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:34:17 -0400
Subject: Re: Merging libata PATA support into the base kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <20060810135945.GV11829@suse.de>
References: <1155144599.5729.226.camel@localhost.localdomain>
	 <p733bc5nm5g.fsf@verdi.suse.de>
	 <1155213464.22922.6.camel@localhost.localdomain>
	 <20060810122056.GP11829@suse.de>
	 <1155219292.22922.13.camel@localhost.localdomain>
	 <20060810135945.GV11829@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Aug 2006 16:54:03 +0100
Message-Id: <1155225243.24077.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-10 am 15:59 +0200, ysgrifennodd Jens Axboe:
> On Thu, Aug 10 2006, Alan Cox wrote:
> HPA mishandling is a given, I agree that is a nasty problem and really
> should be fixed. hangs on resume - the hardware, or the kernel talking

Hang on resume because we don't do the mode setup right from s2ram.
Being worked on by someone at last which is great

> to it? crc errors sounds like bad transfer tuning after resume, but that
> should be pretty identical to the on-boot one.

I *think* this is that the PLLs need resynchronizing after resume from
ram and we don't do that for some chips


