Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132859AbRA1PXk>; Sun, 28 Jan 2001 10:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135420AbRA1PXa>; Sun, 28 Jan 2001 10:23:30 -0500
Received: from mail.zmailer.org ([194.252.70.162]:29965 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S132859AbRA1PXT>;
	Sun, 28 Jan 2001 10:23:19 -0500
Date: Sun, 28 Jan 2001 17:23:12 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Pavel Machek <pavel@suse.cz>
Cc: "David L. Nicol" <david@kasey.umkc.edu>, linux-kernel@vger.kernel.org,
        chris.ricker@genetics.utah.edu
Subject: Re: "no such 386 instruction" with gcc 2.95.2
Message-ID: <20010128172312.S25659@mea-ext.zmailer.org>
In-Reply-To: <3A709EC8.72C3F911@kasey.umkc.edu> <20010127111759.A163@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010127111759.A163@bug.ucw.cz>; from pavel@suse.cz on Sat, Jan 27, 2001 at 11:17:59AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think I must need to upgrade my assembler, but:
> > 2.4.0/Documentation/Changes does not list an assembler version.

	It does, the "binutils" package contain the assembler and linker,
	et.al. of that kind utilities.  The errors quoted below are
	definitely due to "too old" assembler.

> > {standard input}: Assembler messages:
> > {standard input}:996: Error: no such 386 instruction: `movups'
> > {standard input}:1001: Error: no such 386 instruction: `prefetcht0'
> > {standard input}:1005: Error: no such 386 instruction: `movaps'

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
