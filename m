Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbTLOKmQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 05:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTLOKmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 05:42:16 -0500
Received: from albireo.ucw.cz ([81.27.194.19]:41344 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S263491AbTLOKmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 05:42:15 -0500
Date: Mon, 15 Dec 2003 11:42:14 +0100
From: Martin Mares <mj@ucw.cz>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031215104214.GA1495@ucw.cz>
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com> <3FDD8691.80206@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDD8691.80206@intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I did not found this feature in standard.

I did :-)  C99, section 6.7.8 "Initialization", constraint 10:

"... If an object that has static storage duration is not initialized
explicitly, then:

   - if it has pointer type, it is initialized to a null pointer;
   - if it has arithmetic type, it is initialized to (positive or unsigned) zero;

..."

> More, future versions of gcc will give at least warning, if not error, like
> "use of uninitialized variable".

Yes, such warning exists, but only for automatic variables.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Quote of the day: '
