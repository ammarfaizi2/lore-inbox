Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbULTOta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbULTOta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 09:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbULTOta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 09:49:30 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:44507 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261513AbULTOt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 09:49:27 -0500
Subject: Re: [patch] [RFC] make WANT_PAGE_VIRTUAL a config option
From: Dave Hansen <haveblue@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       geert@linux-m68k.org, ralf@linux-mips.org,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.61.0412180020220.793@scrub.home>
References: <E1Cf3bP-0002el-00@kernel.beaverton.ibm.com>
	 <Pine.LNX.4.61.0412170133560.793@scrub.home>
	 <1103244171.13614.2525.camel@localhost>
	 <Pine.LNX.4.61.0412170150080.793@scrub.home>
	 <1103246050.13614.2571.camel@localhost>
	 <Pine.LNX.4.61.0412170256500.793@scrub.home>
	 <1103257482.13614.2817.camel@localhost>
	 <Pine.LNX.4.61.0412171132560.793@scrub.home>
	 <1103299179.13614.3551.camel@localhost>
	 <Pine.LNX.4.61.0412171818090.793@scrub.home>
	 <1103320106.7864.6.camel@localhost>
	 <Pine.LNX.4.61.0412180020220.793@scrub.home>
Content-Type: text/plain
Message-Id: <1103554150.11069.104.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 20 Dec 2004 06:49:10 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-17 at 16:52, Roman Zippel wrote:
> In your case don't put the inline functions into asm/mmzone.h and we 
> should merge the various definition into fewer header files.

OK, I'm sold.  

But, what do you think we should do about the current #defines in
asm/mmzone.h, like pfn_to_page()?  Would it be feasible to put them in
another header that can use proper functions?

-- Dave

