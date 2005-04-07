Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbVDGPal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbVDGPal (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 11:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVDGPal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 11:30:41 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:5066 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262488AbVDGPad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 11:30:33 -0400
Subject: Re: [PATCH 1/4] create mm/Kconfig for arch-independent memory
	options
From: Dave Hansen <haveblue@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <Pine.LNX.4.61.0504070219160.15339@scrub.home>
References: <E1DIViE-0006Kf-00@kernel.beaverton.ibm.com>
	 <42544D7E.1040907@linux-m68k.org> <1112821319.14584.28.camel@localhost>
	 <Pine.LNX.4.61.0504070133380.25131@scrub.home>
	 <1112831857.14584.43.camel@localhost>
	 <Pine.LNX.4.61.0504070219160.15339@scrub.home>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 08:30:24 -0700
Message-Id: <1112887825.14584.59.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 02:30 +0200, Roman Zippel wrote:
> I was hoping for this too, in the meantime can't you simply make it a 
> suboption of DISCONTIGMEM? So an extra option is only visible when it's 
> enabled and most people can ignore it completely by just disabling a 
> single option.

That's reasonable, except that SPARSEMEM doesn't strictly have anything
to do with DISCONTIG.

How about a menu that's hidden under CONFIG_EXPERIMENTAL?

> > I'm not opposed to creating some better help text for those things, I'm
> > just not sure that we really need it, or that it will help end users get
> > to the right place.  I guess more explanation never hurt anyone.
> 
> Some basic explanation with a link for more information can't hurt.

I'll see what I can come up with.

-- Dave

