Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVAQOwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVAQOwq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 09:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbVAQOwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 09:52:46 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:61864 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262813AbVAQOwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 09:52:43 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.10-mm3: swsusp: out of memory on resume (was: Re: Ho ho ho - Linux v2.6.10)
Date: Mon, 17 Jan 2005 15:53:02 +0100
User-Agent: KMail/1.7.1
Cc: hugang@soulinfo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <200501152243.21483.rjw@sisk.pl> <20050116215145.GF2757@elf.ucw.cz>
In-Reply-To: <20050116215145.GF2757@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501171553.02565.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 16 of January 2005 22:51, Pavel Machek wrote:
> Hi!
> 
> > > > > Has this patch been ported to x86_64?  Or is there a newer version of it anywhere,
> > > > > or an alternative?
> > > > > 
> > > > 
> > > > Ok, Here is a new patch with x86_64 support, But I have not machine, So
> > > > Need someone test it. 
> > > 
> > > OK, I will.
> > 
> > I have tested it and it works well.  For me, it speeds up the resume process significantly,
> > so I vote for including it into -mm (at least ;-)).  I'll be testing it further to see if it really
> > solves my "out of memory" problems on resume.
> 
> Try Lukas's patch, it should provide equivalent speedups.

It does.  Still, I don't think it'll solve memory allocation problems on resume,
and the hugang's patch has such a potential.

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
