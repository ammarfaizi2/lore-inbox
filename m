Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267777AbUH2MRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267777AbUH2MRL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 08:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267779AbUH2MRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 08:17:11 -0400
Received: from mail1.kontent.de ([81.88.34.36]:29629 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S267777AbUH2MRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 08:17:09 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [2.6 patch][3/3] mm/ BUG -> BUG_ON conversions
Date: Sun, 29 Aug 2004 14:18:50 +0200
User-Agent: KMail/1.6.2
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040828151137.GA12772@fs.tum.de> <20040828212419.GM12772@fs.tum.de> <20040829120324.GB10112@suse.de>
In-Reply-To: <20040829120324.GB10112@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408291418.50255.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 29. August 2004 14:03 schrieb Jens Axboe:
> > The intention is, to add an option that lets BUG/BUG_ON/WARN_ON/PAGE_BUG 
> > do nothing. This option should be hidden under EMBEDDED.
> > 
> > In some environments, this seems to be desirable.
> 
> That only makes sense if you are using BUG incorrectly. A BUG()
> condition is something that is non-recoverable, undefining that doesn't
> make any sense regardless of the environment.

Why not? Giving reports about unrecoverable errors is sensible
only if the report can be read. On system this is not the case, you
can just salvage the memory and let it crash.

	Regards
		Oliver
